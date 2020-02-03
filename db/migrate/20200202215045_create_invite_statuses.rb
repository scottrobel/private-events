class CreateInviteStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :invite_statuses do |t|
      t.timestamps
      t.string :status
    end
  end
end
