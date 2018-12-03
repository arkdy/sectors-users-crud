class SectorsUsers < ApplicationRecord
  belongs_to :user
  belongs_to :sector

  validates :user, :sector, presence: true
  validates :user_id, uniqueness: { scope: 'sector_id' }
  # validate :one_cto_or_ceo_in_sector

  # shraie_a
  # don't allow user to be in more than one sector, but any number of subsectors whithin it
  def user_can_be_in_one_sector_only

  end

  # shraie_a
  # check if there is no more than one CEO/CTO in the sector being added
  def one_cto_or_ceo_in_sector
    restricted_roles = %w[cto ceo]
    parent_sector = sector.parent_sector.present? ? sector.parent_sector : sector
    allowed_users = parent_sector.users.where(role: restricted_roles)

    return if allowed_users.include? user # sectors/subsectors can be added for current CEO/CTO

    # no new CEO/CTOs are allowed if they're already in the sector
    unless (parent_sector.users.pluck(:role) & restricted_roles).empty?
      errors.add(:base, I18n.t('sectors_users.error.one_cto_ceo_in_sector')) if restricted_roles.include?(user.role)
    end
  end
end
