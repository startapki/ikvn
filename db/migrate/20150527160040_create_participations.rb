class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :role, default: 'author'

      t.references :user, null: false, index: true, foreign_key: true
      t.references :season, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :participations, [:role, :user_id, :season_id], unique: true
  end
end
