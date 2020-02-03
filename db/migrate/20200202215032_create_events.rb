class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :event_photo
      t.string :description
      t.string :location
      t.datetime :time
      t.integer :event_organizer_id
      t.timestamps
    end
  end
end
