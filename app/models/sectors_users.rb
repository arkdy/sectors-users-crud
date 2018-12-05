class SectorsUsers < ApplicationRecord
  belongs_to :user
  belongs_to :sector

  validates :user, presence: true
  validates :sector, presence: true
  validates :user_id, uniqueness: { scope: 'sector_id' }

  # shraie_a
  # don't allow user to be in more than one sector, but any number of subsectors whithin it
  def user_can_be_in_one_sector_only

  end

end
