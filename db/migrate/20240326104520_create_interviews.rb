class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.string :interview_type, null: false
      t.text :details
      t.datetime  :start_date
      t.datetime  :end_date
      t.integer :point, default: 1, null: false
      t.references :job_listing, null: false, foreign_key: { to_table: :job_listings}

      t.timestamps
    end
  end
end
