class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :content

      t.references :tour, null: false, index: true, foreign_key: true

      t.integer :solutions_count, null: false, default: 0 # counter_cache
      t.integer :position # acts_as_list

      t.timestamps null: false
    end
  end
end
