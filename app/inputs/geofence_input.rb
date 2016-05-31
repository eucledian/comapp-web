class GeofenceInput
  include Formtastic::Inputs::Base

  # rendering html
  def to_html
    input_wrapping do
      label_html <<
      builder.template.content_tag(:input, '', custom_text_options('search')) <<
      builder.template.content_tag(:div, '', map_tag_options) <<
      builder.hidden_field(method, input_html_options)
    end
  end

  protected

  def map_tag_options
    custom_input_options('map').merge(class: 'geofence_input')
  end

  def custom_text_options(name)
    input_html_options.merge(id: "#{input_html_options[:id]}_#{name}", type: :text)
  end

  def custom_input_options(name=nil)
    input_html_options.merge(id: "#{input_html_options[:id]}_#{name}")
  end
end
