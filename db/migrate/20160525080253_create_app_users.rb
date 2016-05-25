class CreateAppUsers < ActiveRecord::Migration
  def change
    create_table :app_users do |t|
      t.string :name, null: false
      t.string :last_names, null: false
      t.string :mail, null: false
      t.string :password, null: false
      t.timestamps null: false
    end
  end
end
