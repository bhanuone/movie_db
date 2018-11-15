class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :name
      # t.references :genre, foreign_key: true
      # t.float :rating 
      t.text :overview
      t.string :status
      t.integer :tvdb_id
      t.string :network 
      t.string :first_aired
      t.string :genre, array: true

      t.timestamps
    end
  end
end
