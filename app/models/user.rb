class User < ApplicationRecord
  has_many :sectors_users, dependent: :destroy
  has_many :sectors, through: :sectors_users

  accepts_nested_attributes_for :sectors_users, allow_destroy: true

  enum role: [:decideur, :secretaire, :comptable, :cto, :ceo]
  validates :role, presence: true

  def belongs_to_sector?(sector_id)
    sectors.where(parent_id: nil, id: sector_id).present?
  end

  def belongs_to_subsector?(subsector_id)
    sectors.where.not(parent_id: nil).where(id: subsector_id).present?
  end

end
