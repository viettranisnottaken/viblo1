class RemoveRequestFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :request, :text
  end
end
