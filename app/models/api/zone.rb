class Api::Zone < Zone

  module Json
    List = {
      only: [:id, :name, :lat, :lng],
      include: {
        surveys: {
          only: [:id, :zone_id, :is_active, :name, :description],
          include: {
            survey_fields: {
              only: [:id, :survey_id, :position, :data_type, :identity, :name],
              include: {
                survey_field_options: {
                  only: [:id, :survey_field_id, :option_value]
                },
                survey_field_validations: {
                  only: [:id, :survey_field_id, :identity, :validation_args]
                }
              }
            }
          }
        }
      }
    }
  end

  def self.list
    all
  end

end
