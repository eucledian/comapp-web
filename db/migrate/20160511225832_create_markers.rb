class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :name, null: false
      t.string :extension
      t.timestamps null: false
    end
  end
end
