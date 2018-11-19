class AddTvdbIdToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :tvdb_id, :integer
  end
end
