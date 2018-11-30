class User < ApplicationRecord
  has_many :sectors_users
  has_many :sectors, through: :sectors_users

  enum role: [:decideur, :secretaire, :comptable, :cto, :ceo]
  validates :role, presence: true

  def belongs_to_sector?(sector_id)
    sectors.where(parent_id: nil, id: sector_id).present?
  end

  def belongs_to_subsector?(subsector_id)
    sectors.where.not(parent_id: nil).where(id: subsector_id).present?
  end

end
