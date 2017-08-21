#!/usr/bin/env ruby

require_relative 'Expression'

class CompositeExpression < Expression

    attr_accessor :expressions

    def initialize(exprs)
        @expressions = exprs
    end

    def to_s
        s = "composite:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
