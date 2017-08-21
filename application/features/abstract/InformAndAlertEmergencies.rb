#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformAndAlertEmergencies

    @@name = :inform_and_alert_emergencies
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
