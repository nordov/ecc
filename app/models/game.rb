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
class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :publisher_id, message: "This game name already exists for this publicher" }
  validates :nickname, :publisher_id, presence: true

  belongs_to :publisher,
    class_name: :User,
    foreign_key: :publisher_id

  def upvote
    self.likes += 1
    self.save
  end

  def downvote
    self.dislikes += 1
    self.save
  end
end
