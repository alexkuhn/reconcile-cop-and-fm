#!/usr/bin/env ruby

require_relative 'Earthquake'

class ERS

    def method_missing(sym, *args)
        "* no such method #{sym} *"
    end

end
