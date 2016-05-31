#
# FieldIdentifiable Concern
# provides a shared identity module and
# boolean instance methods
#
module FieldIdentifiable

  extend ActiveSupport::Concern

  # modules
  module Identity
    LBase = 'survey_field.identity'
    Text = 0
    # Textarea = 1
    # Checkbox = 2
    # Radio = 3
    Select = 4
    # Matrix = 5
    # Catalog = 6
    # File = 7
    List = {
      Text => {
        name: I18n.t("#{LBase}.text"),
        key: 'text'
      },
      # Textarea => {
      #   name: I18n.t("#{LBase}.textarea"),
      #   key: 'textarea'
      # },
      # Checkbox => {
      #   name: I18n.t("#{LBase}.checkbox"),
      #   key: 'checkbox'
      # },
      # Radio => {
      #   name: I18n.t("#{LBase}.radio"),
      #   key: 'radio'
      # },
      Select => {
        name: I18n.t("#{LBase}.select"),
        key: 'select'
      }
      # ,
      # Matrix => {
      #   name: I18n.t("#{LBase}.matrix"),
      #   key: 'matrix'
      # },
      # Catalog => {
      #   name: I18n.t("#{LBase}.catalog"),
      #   key: 'catalog'
      # },
      # File => {
      #   name: I18n.t("#{LBase}.file"),
      #   key: 'file'
      # }
    }
    def self.keys
      @@keys ||= List.keys
    end
    def self.select_values
      @@select_values ||= List.map do |k, el|
        [el[:name], k]
      end
    end
    def self.filter_vals
      @@filter_vals ||= ->{
        list = []
        List.each do |k, el|
          list << { id: k, name: el[:name] }
        end
        list
      }.call
    end
    def self.api_values
      @@api_values ||= ->{
        list = {}
        List.each do |k, el|
          list[el[:key]] = k
        end
        list.to_json
      }.call
    end
  end

  included do

    def is_matrix?
      @bool_is_matrix ||= (self.identity == Identity::Matrix)
    end

    def is_checkbox?
      @bool_is_checkbox ||= (self.identity == Identity::Checkbox)
    end

  end

end
