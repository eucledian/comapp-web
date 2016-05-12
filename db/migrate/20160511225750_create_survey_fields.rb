class CreateSurveyFields < ActiveRecord::Migration
  def change
    create_table :survey_fields do |t|
      t.belongs_to :survey, null: false, index: true
      t.integer :position, null: false, default: 0
      t.integer :data_type, null: false
      t.integer :identity, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
    add_foreign_key :survey_fields, :surveys, on_delete: :cascade, on_update: :cascade
  end
end
