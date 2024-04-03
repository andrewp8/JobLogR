class CreateAiMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_messages do |t|
      t.text :role, array: true, default: []
      t.text :body, array: true, default: []
      t.references :job_listing, null: false, foreign_key: {to_table: :job_listings}

      t.timestamps
    end
  end
end
