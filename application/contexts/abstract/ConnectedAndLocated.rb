#!/usr/bin/env ruby

require_relative '../../../framework/Context'

class ConnectedAndLocated

    @@name = :connected_and_located
    @@context = Context.new(@@name)

    def self.get
        @@context
    end

    def self.name
        @@name
    end

end
