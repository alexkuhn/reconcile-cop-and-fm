#!/usr/bin/env ruby

require_relative 'ERSEarthquake'

class ERS

    def method_missing(sym, *args)
        "* no such method #{sym} *"
    end

end
