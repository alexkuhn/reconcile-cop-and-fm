#!/usr/bin/env ruby

require_relative '../../../framework/Context'

class WiFi

    @@name = :wifi
    @@context = Context.new(@@name)

    def self.get
        @@context
    end

    def self.name
        @@name
    end

end