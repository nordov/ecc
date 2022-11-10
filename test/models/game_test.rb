# == Schema Information
#
# Table name: games
#
#  id           :integer          not null, primary key
#  dislikes     :integer          default(0)
#  image        :integer
#  likes        :integer          default(0)
#  name         :string
#  nickname     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  publisher_id :integer          not null
#
# Indexes
#
#  index_games_on_name           (name)
#  index_games_on_name_and_user  ("name", "user") UNIQUE
#  index_games_on_nickname       (nickname)
#
require "test_helper"

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
