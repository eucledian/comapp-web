class CreateAppUserSurveyResponses < ActiveRecord::Migration
  def change
    create_table :app_user_survey_responses do |t|
      t.belongs_to :app_user_survey, null: false, index: true
      t.belongs_to :survey_field, null: false, index: true
      t.text :response, null: false
      t.timestamps null: false
    end
    add_foreign_key :app_user_survey_responses, :app_user_surveys,
      on_delete: :cascade, on_update: :cascade
    add_foreign_key :app_user_survey_responses, :survey_fields,
      on_delete: :cascade, on_update: :cascade
  end
end
