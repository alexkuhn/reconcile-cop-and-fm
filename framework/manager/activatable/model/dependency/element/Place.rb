#!/usr/bin/env ruby

require_relative 'Node'

class Place < Node

    attr_accessor :tokens

    def initialize(category, activatable, active_state)
        super(category, activatable, active_state)
        @node_type = :place
        @tokens = 0
    end

    def to_s
        "#{super}tokens: #{@tokens}\n"
    end

end
