#!/usr/bin/env ruby

require_relative 'Expression'

class BasicExpression < Expression

    attr_accessor :activatable

    def initialize(act)
        @activatable = act
    end

    def satisfied?
        @activatable.active?
    end

    def to_s
        "basic: #{activatable.name}"
    end

end
