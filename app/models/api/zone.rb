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
                  only: [:id, :name, :survey_field_id, :option_value]
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

  def self.to_csv
    attrs = %w{id name lat lng}
    CSV.generate(headers: true) do |csv|
      csv << attrs
      all.each do |zone|
        zone.surveys.each do |el|
          csv << attrs.map{ |attr| zone.send(attr) }
        end
      end
    end
  end

end
