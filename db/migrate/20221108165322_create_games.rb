class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :nickname
      t.integer :likes, default: 0
      t.integer :dislikes, default: 0
      t.integer :publisher_id, null: false
      t.integer :image

      t.timestamps
    end

    add_index :games, :name
    add_index :games, [ :name, :user ], unique: true
    add_index :games, :nickname
  end
end
