module Validatable

  extend ActiveSupport::Concern

  module ValidationDataType
    String = 0
    Number = 1
    Boolean = 2
    Integer = 3
    Array = 4
    Regex = 5
    List = {
      'string' => String,
      'number' => Number,
      'boolean' => Boolean,
      'integer' => Integer,
      'array' => Array,
      'regex' => Regex
    }
  end

  module ValidationIdentity
    LBase = 'app.model.field_validation.identity'
    ArgsLBase = "#{LBase}.args"
    Presence = 0
    Length = 1
    Numericality = 2
    Inclusion = 3
    Exclusion = 4
    Uniqueness = 5
    Format = 6
    Confirmation = 7
    List = {
      Presence => {
        name: I18n.t("#{LBase}.presence"),
        key: :presence,
        args: {},
        extra_args: {}
      },
      Length => {
        name: I18n.t("#{LBase}.length"),
        key: :length,
        args: {
          minimum: {
            name: I18n.t("#{ArgsLBase}.minimum"),
            key: :minimum,
            data_type: ValidationDataType::Integer
          },
          maximum: {
            name: I18n.t("#{ArgsLBase}.maximum"),
            key: :maximum,
            data_type: ValidationDataType::Integer
          },
          is: {
            name: I18n.t("#{ArgsLBase}.is"),
            key: :is,
            data_type: ValidationDataType::Integer
          }
        },
        extra_args: {
          allow_blank: true
        }
      },
      Numericality => {
        name: I18n.t("#{LBase}.numericality"),
        key: :numericality,
        args: {
          only_integer: {
            name: I18n.t("#{ArgsLBase}.only_integer"),
            key: :only_integer,
            data_type: ValidationDataType::Boolean
          },
          greater_than: {
            name: I18n.t("#{ArgsLBase}.greater_than"),
            key: :greater_than,
            data_type: ValidationDataType::Number
          },
          greater_than_or_equal_to: {
            name: I18n.t("#{ArgsLBase}.greater_than_or_equal_to"),
            key: :greater_than_or_equal_to,
            data_type: ValidationDataType::Number
          },
          equal_to: {
            name: I18n.t("#{ArgsLBase}.equal_to"),
            key: :equal_to,
            data_type: ValidationDataType::Number
          },
          less_than: {
            name: I18n.t("#{ArgsLBase}.less_than"),
            key: :less_than,
            data_type: ValidationDataType::Number
          },
          less_than_or_equal_to: {
            name: I18n.t("#{ArgsLBase}.less_than_or_equal_to"),
            key: :less_than_or_equal_to,
            data_type: ValidationDataType::Number
          },
          odd: {
            name: I18n.t("#{ArgsLBase}.odd"),
            key: :odd,
            data_type: ValidationDataType::Boolean
          },
          even: {
            name: I18n.t("#{ArgsLBase}.even"),
            key: :even,
            data_type: ValidationDataType::Boolean
          }
        },
        extra_args: {
          allow_nil: true
        }
      },
      Inclusion => {
        name: I18n.t("#{LBase}.inclusion"),
        key: :inclusion,
        args: {
          in: {
            name: I18n.t("#{ArgsLBase}.in"),
            key: :in,
            data_type: ValidationDataType::Array,
            required: true
          }
        },
        extra_args: {
          allow_blank: true
        }
      },
      Exclusion => {
        name: I18n.t("#{LBase}.exclusion"),
        key: :exclusion,
        args: {
          in: {
            name: I18n.t("#{ArgsLBase}.in"),
            key: :in,
            data_type: ValidationDataType::Array,
            required: true
          }
        },
        extra_args: {
          allow_blank: true
        }
      },
      Uniqueness => {
        name: I18n.t("#{LBase}.uniqueness"),
        key: :uniqueness,
        args: {
          scope: {
            name: I18n.t("#{ArgsLBase}.scope"),
            key: :scope,
            data_type: ValidationDataType::String
          }
        },
        extra_args: {
          allow_blank: true
        }
      },
      Format => {
        name: I18n.t("#{LBase}.format"),
        key: :format,
        args: {
          with: {
            name: I18n.t("#{ArgsLBase}.with"),
            key: :with,
            data_type: ValidationDataType::Regex,
            required: true
          }
        },
        extra_args: {
          allow_blank: true
        }
      },
      Confirmation => {
        name: I18n.t("#{LBase}.confirmation"),
        key: :confirmation,
        args: {},
        extra_args: {
          allow_blank: true
        }
      }
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
  end

  class Validation

    attr_accessor :identity, :data, :args, :extra_args, :errors

    def initialize(args={})
      opts = { data: {}, errors: {} }
      opts.merge!(args)
      opts.each do |k, v|
        self.send("#{k}=", v)
      end
      self.init_args
      self.init_extra_args
    end

    def init_args
      self.args = {}
      args = self.identity[:args]
      args.each do |k, v|
        el = ValidationArg.new(v)
        el.value = self.data[k]
        self.args[k] = el
      end
    end

    def init_extra_args
      self.extra_args = {}
      extra_args = self.identity[:extra_args]
      extra_args.each do |k, v|
        self.extra_args[k] = v
      end
    end

    def valid?
      val = true
      self.errors = {}
      self.args.each do |k, el|
        el_valid = el.valid?
        val = val && el_valid
        self.errors[el.key] = el.errors unless el_valid
      end
      val
    end

    def to_json
      res = {}
      self.args.each do |k, el|
        tmp = el.to_json
        res[k] = tmp if tmp.present?
      end
      self.extra_args.each do |k, el|
        tmp = el.to_json
        res[k] = tmp if tmp.present?
      end
      res.to_json
    end

  end

  class ValidationArg

    ErrorLBase = 'errors.messages'

    module Separator
      Comma = ','
    end

    module Regex
      Integer = /\A[+\-]?\d+\Z/
      Boolean = /[0-1]/
    end

    attr_accessor :key, :name, :value, :data_type, :required, :errors

    def initialize(args={})
      opts = { required: false, errors: [] }
      opts.merge!(args)
      opts.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def valid?
      self.errors = []
      val = self.validate_presence
      if val
        val = self.validate_data_type
      end
      val
    end

    def to_json
      res = nil
      res = {
      #  required: self.required,
      #  data_type: self.data_type,
        value: self.value
      } if self.value.present?
      res
    end

    def validate_presence
      res = !self.required || self.value.present?
      unless res
        msg = I18n.t("#{ErrorLBase}.blank")
        self.errors.push(msg)
      end
      res
    end

    def validate_data_type
      res = true
      if self.value.present?
        case self.data_type
          when ValidationDataType::Boolean
            rex = Regex::Boolean
            res = (self.value =~ rex)
            self.value = self.value.to_i if res
          when ValidationDataType::Integer
            rex = Regex::Integer
            res = (self.value =~ rex)
            self.value = self.value.to_i if res
          when ValidationDataType::Number
            begin
              self.value = Float(self.value)
            rescue
              res = false
            end
          when ValidationDataType::Array
            res = validate_array
        end
      end
      unless res
        msg = I18n.t("#{ErrorLBase}.invalid")
        self.errors.push(msg)
      end
      res
    end

    # BIG
    def validate_array
      res = true
      els = self.value.split(Separator::Comma)
      #field = self.field.
      els.each do |el|
        p '--------------'
        p "validate array #{el}"
        p '--------------'
      end
      self.value = els if res
      res
    end

  end

  included do

    attr_accessor :v_args

    validate :validate_validation_errors
    before_save :set_validation_args

    def validation_args=(val)
      res = nil
      res = Validation.new(identity: self.validation_identity, data: val) if self.validation_identity.present?
      self.v_args = res
    end

    def validation_opts
      @validation_opts ||= ->{
        res = {}
        args = {}
        identity = self.validation_identity
        if self.validation_args.present?
          els = JSON.parse(self.validation_args)
          args = {}
          els.each do |k, arg|
            identity_arg = identity[:args][k.to_sym]
            identity_extra_arg = identity[:extra_args][k.to_sym]
            val = arg['value']
            if identity_arg.present?
              data_type = identity_arg[:data_type]
              case data_type
                when ValidationDataType::Number
                  val = val.to_f
                when ValidationDataType::Boolean
                  val = (val == 1)
                  val = nil if (val == false)
                when ValidationDataType::Integer
                  val = val.to_i
                when ValidationDataType::Regex
                  val = Regexp.new("\\A(#{val})\\Z")
              end
            elsif identity_extra_arg.present?
              val = identity_extra_arg
            end
            args[k.to_sym] = val if val.present?
          end
        end
        args = true if args.empty?
        key = identity[:key]
        res.merge!(key => args)
      }.call
    end

    protected

    def validate_validation_errors
      if self.v_args.present? && !self.v_args.valid?
        self.errors.add(:validation_args, self.validation_args.errors)
      end
    end

    def validation_identity
      @validation_identity ||= ValidationIdentity::List[self.identity.to_i]
    end

    def set_validation_args
      if self.v_args.present?
        value = self.v_args.to_json
        write_attribute(:validation_args, value)
      end
    end

  end

end
