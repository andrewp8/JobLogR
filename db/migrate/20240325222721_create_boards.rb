class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :board_name
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
