#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class AlertUser

    @@name = :alert_user
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
