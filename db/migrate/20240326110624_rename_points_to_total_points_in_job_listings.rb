class RenamePointsToTotalPointsInJobListings < ActiveRecord::Migration[7.0]
  def change
    rename_column :job_listings, :points, :total_points
  end
end
