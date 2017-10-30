class CreateBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :beers do |t|
      t.string :name, null: false
      t.string :brewery, null: false

      t.timestamps
    end
  end
end
