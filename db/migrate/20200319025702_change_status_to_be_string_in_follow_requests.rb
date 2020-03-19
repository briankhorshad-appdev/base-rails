class ChangeStatusToBeStringInFollowRequests < ActiveRecord::Migration[6.0]
  def change
    change_column :follow_requests, :status, :string
  end
end
