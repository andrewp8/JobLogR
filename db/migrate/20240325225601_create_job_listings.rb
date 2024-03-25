class CreateJobListings < ActiveRecord::Migration[7.0]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.string :company
      t.string :location
      t.float :salary
      t.integer :status, default: 0, null: false
      t.text :details
      t.string :details_summary
      t.references :applicant, null: false, foreign_key: { to_table: :users }
      t.integer :points, default: 0, null: false
      t.references :board, null: false, foreign_key: { to_table: :boards }

      t.timestamps
    end
  end
end
