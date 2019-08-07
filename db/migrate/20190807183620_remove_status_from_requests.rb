class RemoveStatusFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :status, :string
  end
end
