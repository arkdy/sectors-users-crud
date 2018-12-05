class Sector < ApplicationRecord
  # sectors can be nested as subsectors

  scope :parent_only, -> { where(parent_id: nil) }
  scope :child_only, -> { where.not(parent_id: nil) }

  before_create :set_name

  has_many :subsectors, class_name: 'Sector', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_sector, class_name: 'Sector', foreign_key: 'parent_id', optional: true

  has_many :sectors_users
  has_many :users, through: :sectors_users

  validate :one_cto_or_ceo_in_sector

  def has_users?
    users.count > 0
  end

  def set_name
    return if name.present?

    parent_id.present? ? self.name = "Subsector" : self.name = "Sector"
  end

  private

  # shraie_a
  # check if there is no more than one CEO/CTO in the sector being added
  def one_cto_or_ceo_in_sector
    restricted_roles = %w[cto ceo]
    parent = parent_sector.present? ? parent_sector : self
    allowed_users = parent.users.where(role: restricted_roles)

    # errors.add(:sectors, 'error: one_cto_ceo_in_sector')

      #return if allowed_users.include? user # sectors/subsectors can be added for current CEO/CTO

    # no new CEO/CTOs are allowed if they're already in the sector
    # unless (parent_sector.users.pluck(:role) & restricted_roles).empty?
    #   errors.add(:base, I18n.t('sectors_users.error.one_cto_ceo_in_sector')) if restricted_roles.include?(user.role)
    # end
  end

end