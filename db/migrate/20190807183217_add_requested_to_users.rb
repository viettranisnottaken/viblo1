class AddRequestedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :requested, :string
  end
end
