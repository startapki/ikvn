class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description

      t.references :tour, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
