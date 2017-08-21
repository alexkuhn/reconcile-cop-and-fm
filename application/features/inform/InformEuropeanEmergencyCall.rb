#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformEuropeanEmergencyCall

    @@name = :inform_european_emergency_call
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :emergency_call,
        112)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
