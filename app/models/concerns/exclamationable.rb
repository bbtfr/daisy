module Exclamationable
  extend ActiveSupport::Concern

  module ClassMethods
    def define_exclamation_dot_method attrs_name
      attrs_name = attrs_name.to_s
      class_eval <<-EOM
        def #{attrs_name}! *args
          #{attrs_name}(*args).save(validate: false)
        end
      EOM
    end

    def define_exclamation_and_method attrs_name
      attrs_name = attrs_name.to_s
      class_eval <<-EOM
        def #{attrs_name}! *args
          #{attrs_name}(*args)
          save(validate: false)
        end
      EOM
    end
  end
end
