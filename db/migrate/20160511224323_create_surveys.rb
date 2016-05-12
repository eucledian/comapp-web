class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :zone, null: false, index: true
      t.boolean :is_active, null: false, default: false
      t.string :name, null: false
      t.string :description
      t.timestamps null: false
    end
    add_foreign_key :surveys, :zones, on_delete: :cascade, on_update: :cascade
  end
end
