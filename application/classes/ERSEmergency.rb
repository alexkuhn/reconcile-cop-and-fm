#!/usr/bin/env ruby

class ERSEmergency

    attr_accessor :type
    attr_accessor :properties

    def initialize
        @type = :generic
        @properties = {}
    end

end
