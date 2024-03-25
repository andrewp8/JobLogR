# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  board_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Board < ApplicationRecord
  has_many :job_listings
end
