# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  board_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Board < ApplicationRecord
  has_many :job_listings, dependent: :destroy
  belongs_to :user

  validates :board_name, presence: true
end
