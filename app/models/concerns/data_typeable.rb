#
# DataTypeable Concern
# validates data_type db field
# provides find_by_data_type class method
# and a shared datatype module
#
module DataTypeable

  extend ActiveSupport::Concern

  module DataType
    LBase = 'survey_field.data_type'
    String = 0
    Integer = 1
    Float = 2
    Date = 3
    DateTime = 4
    RawDate = 5
    Place = 6
    List = {
      String => {
        name: I18n.t("#{LBase}.string"),
        key: 'string'
      },
      Integer => {
        name: I18n.t("#{LBase}.integer"),
        key: 'integer'
      },
      Float => {
        name: I18n.t("#{LBase}.float"),
        key: 'float'
      },
      Date => {
        name: I18n.t("#{LBase}.date"),
        key: 'date'
      },
      DateTime => {
        name: I18n.t("#{LBase}.date_time"),
        key: 'date_time'
      },
      RawDate => {
        name: I18n.t("#{LBase}.raw_date"),
        key: 'raw_date'
      },
      Place => {
        name: I18n.t("#{LBase}.place"),
        key: 'place'
      }
    }
    def self.keys
      @@keys ||= List.keys
    end
    def self.get_name(val)
      res = nil
      obj = List[val]
      res = obj[:name] if obj.present?
      res
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

    scope :filter_by_data_type, ->(dt){ where(data_type: dt) }

    validates :data_type, numericality: { only_integer: true }, inclusion: { in: DataType.keys }, presence: true

  end

  module ClassMethods

    def find_by_data_type(dt)
      self.base.filter_by_data_type(dt)
    end

  end

end
