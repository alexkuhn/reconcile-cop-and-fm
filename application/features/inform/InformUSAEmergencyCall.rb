#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformUSAEmergencyCall

    @@name = :inform_usa_emergency_call
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :emergency_call,
        911)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
