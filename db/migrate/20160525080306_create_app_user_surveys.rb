class CreateAppUserSurveys < ActiveRecord::Migration
  def change
    create_table :app_user_surveys do |t|
      t.belongs_to :app_user, null: false, index: true
      t.belongs_to :survey, null: false, index: true
      t.timestamps null: false
    end
    add_foreign_key :app_user_surveys, :app_users,
      on_delete: :cascade, on_update: :cascade
    add_foreign_key :app_user_surveys, :surveys,
      on_delete: :cascade, on_update: :cascade
  end
end
