class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries do |t|
      t.string :name, null: false
      t.string :brewerydbid

      t.timestamps
    end
  end
end
