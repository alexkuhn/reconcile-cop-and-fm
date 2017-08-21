#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class AlertInDanger

    @@name = :alert_in_danger
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
