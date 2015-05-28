class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description

      t.references :season, null: false, index: true, foreign_key: true

      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :reviewed_at

      t.timestamps null: false
    end
  end
end
