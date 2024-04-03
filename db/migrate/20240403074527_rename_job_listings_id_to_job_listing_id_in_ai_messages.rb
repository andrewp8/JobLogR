class RenameJobListingsIdToJobListingIdInAiMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :ai_messages, :job_listings_id, :job_listing_id
  end
end
