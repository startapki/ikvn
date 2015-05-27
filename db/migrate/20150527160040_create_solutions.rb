class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :content

      t.references :problem, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
