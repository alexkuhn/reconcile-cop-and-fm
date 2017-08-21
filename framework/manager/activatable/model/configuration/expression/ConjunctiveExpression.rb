#!/usr/bin/env ruby

require_relative 'CompositeExpression'

class ConjunctiveExpression < CompositeExpression

    def satisfied?
        res = true
        @expressions.each do |expr|
            res = (res and expr.satisfied?)
        end
        res
    end

    def to_s
        s = "conjunction:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
