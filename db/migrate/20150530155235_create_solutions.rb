class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :content

      t.references :problem, null: false, index: true, foreign_key: true
      t.references :participation, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :solutions, [:problem_id, :participation_id], unique: true
  end
end
