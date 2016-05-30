class CreateAppUserTokens < ActiveRecord::Migration
  def change
    create_table :app_user_tokens do |t|
      t.integer  :user_id, limit: 8, null: false
      t.integer  :identity,null: false
      t.text     :token, null: false
      t.text     :secret, null: false
      t.datetime :expires_at
      t.timestamps null: false
    end

    add_foreign_key :app_user_tokens, :app_users, column: :user_id, on_update: :cascade, on_delete: :cascade
  end
end
