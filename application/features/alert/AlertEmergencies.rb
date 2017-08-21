#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class AlertEmergencies

    @@name = :alert_emergencies
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :alert,
        lambda do
            s = ""
            @emergencies.each do |e|
                if (Context.get(:earthquake).active? and e.type == :Earthquake) or
                    (Context.get(:wildfire).active? and e.type == :Wildfire)
                    s += "#{e.type} has been detected!\n\t "
                end
            end
            s
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
