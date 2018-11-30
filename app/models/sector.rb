class Sector < ApplicationRecord
  # sectors can be nested as subsectors

  scope :parent_only, -> { where(parent_id: nil) }
  scope :child_only, -> { where.not(parent_id: nil) }

  before_create :set_name

  has_many :subsectors, class_name: 'Sector', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent_sector, class_name: 'Sector', foreign_key: 'parent_id', optional: true

  has_many :sectors_users
  has_many :users, through: :sectors_users

  def has_users?
    users.count > 0
  end

  def set_name
    return if name.present?

    parent_id.present? ? self.name = "Subsector" : self.name = "Sector"
  end

end