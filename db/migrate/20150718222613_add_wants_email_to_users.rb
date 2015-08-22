class AddWantsEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wants_email, :boolean, default: true
  end
end
