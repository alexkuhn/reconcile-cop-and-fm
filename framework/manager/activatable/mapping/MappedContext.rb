#!/usr/bin/env ruby

require_relative 'MappedActivatable'

class MappedContext < MappedActivatable

    def to_s
        "mapped_context: #{@activatable}\n"
    end
    
end
