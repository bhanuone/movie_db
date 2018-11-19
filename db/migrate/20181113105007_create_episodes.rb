class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :overview
      t.date :air_date
      t.integer :episode_number
      t.references :series, foreign_key: true
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
