class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
