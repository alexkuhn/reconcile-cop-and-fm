#!/usr/bin/env ruby

require_relative 'ERSEarthquake'

class ERS

    def method_missing(sym, *args)
        "-"
    end

end
