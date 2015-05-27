class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.text :description

      t.references :league, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
