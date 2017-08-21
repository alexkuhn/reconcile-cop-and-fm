#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class AlertInDanger

    @@name = :alert_in_danger
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :alert,
        lambda do
            s = "#{proceed}You are in danger!\n\t "
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
