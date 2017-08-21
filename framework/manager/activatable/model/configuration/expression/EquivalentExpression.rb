#!/usr/bin/env ruby

require_relative 'CompositeExpression'

class EquivalentExpression < CompositeExpression

    def satisfied?
        expr1 = @expressions[0].satisfied?
        expr2 = @expressions[1].satisfied?
        (expr1 and expr2) or ((not expr1) and (not expr2))
    end

    def to_s
        s = "equivalence:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
