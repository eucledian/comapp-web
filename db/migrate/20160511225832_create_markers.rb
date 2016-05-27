class CreateMarkers < ActiveRecord::Migration
  def up
    create_table :markers do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
    add_attachment :markers, :icon
  end

  def down
    remove_attachment :markers, :icon
    drop_table :markers
  end
end
