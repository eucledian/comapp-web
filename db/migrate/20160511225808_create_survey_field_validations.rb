class CreateSurveyFieldValidations < ActiveRecord::Migration
  def change
    create_table :survey_field_validations do |t|
      t.belongs_to :survey_field, null: false, index: true
      t.string :name, null: false
      t.text :option_value, null: false
      t.timestamps null: false
    end
    add_foreign_key :survey_field_validations, :survey_fields, on_delete: :cascade, on_update: :cascade
  end
end
