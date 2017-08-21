#!/usr/bin/env ruby

require_relative 'CompositeExpression'

class DisjunctiveExpression < CompositeExpression

    def satisfied?
        res = false
        @expressions.each do |expr|
            res = (res or expr.satisfied?)
        end
        res
    end

    def to_s
        s = "disjunction:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
