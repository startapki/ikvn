class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.text :description

      t.references :tournament, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
