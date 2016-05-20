ActiveAdmin.register SurveyField do

  # associations
  belongs_to :survey

  form do |f|
    f.inputs 'Detalles' do
      if f.object.new_record?
        f.input :zone_id, as: :hidden, input_html: { value: zone.id }
      end
      f.input :name
      f.input :is_active
      f.input :description
    end
    f.actions
  end

end
