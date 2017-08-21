#!/usr/bin/env ruby

require_relative 'CompositeExpression'

class NegativeExpression < CompositeExpression

    def satisfied?
        expr = @expressions[0].satisfied?
        not expr
    end

    def to_s
        s = "negation:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
