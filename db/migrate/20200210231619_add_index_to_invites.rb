class AddIndexToInvites < ActiveRecord::Migration[6.0]
  def change
    add_index :invites, [:user_id, :event_id], unique: true
  end
end
