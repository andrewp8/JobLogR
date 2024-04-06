class CreateJobListings < ActiveRecord::Migration[7.0]
  def change
    create_table :job_listings do |t|
      t.string :title, null: false
      t.string :company, null: false
      t.string :location
      t.float :salary
      t.integer :status, default: 0, null: false
      t.string :job_url
      t.string :portal_url
      t.text :details
      t.string :details_summary
      t.integer :total_points, default: 0, null: false
      t.references :board, null: false, foreign_key: { to_table: :boards }

      t.timestamps
    end
  end
end
