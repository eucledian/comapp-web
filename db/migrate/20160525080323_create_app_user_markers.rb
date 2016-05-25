class CreateAppUserMarkers < ActiveRecord::Migration
  def change
    create_table :app_user_markers do |t|
      t.belongs_to :app_user, null: false, index: true
      t.belongs_to :marker, null: false, index: true
      t.belongs_to :zone, null: false, index: true
      t.float :lat, null: false
      t.float :lng, null: false
      t.timestamps null: false
    end
    add_foreign_key :app_user_markers, :app_users,
      on_delete: :cascade, on_update: :cascade
    add_foreign_key :app_user_markers, :markers,
      on_delete: :cascade, on_update: :cascade
    add_foreign_key :app_user_markers, :zones,
      on_delete: :cascade, on_update: :cascade
  end
end
