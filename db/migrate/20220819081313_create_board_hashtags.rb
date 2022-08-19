class CreateBoardHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :board_hashtags do |t|
      t.references :board, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
