class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :season, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
