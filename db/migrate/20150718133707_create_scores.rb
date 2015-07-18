class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value, default: 0
      t.references :participation, index: true, foreign_key: true
      t.references :solution, index: true, foreign_key: true
    end
  end
end
