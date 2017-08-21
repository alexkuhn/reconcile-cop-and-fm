#!/usr/bin/env ruby

class Emergency

    attr_accessor :type

    def initialize
        @type = :generic
        @properties = {}
    end

end
