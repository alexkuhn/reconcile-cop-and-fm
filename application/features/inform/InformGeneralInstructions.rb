#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformGeneralInstructions

    @@name = :inform_general_instructions
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform,
        lambda do
            "#{inform_general_instructions}"
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform_general_instructions,
        lambda do
            "In case of emergency, stay calm and call #{@emergency_call}."
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
