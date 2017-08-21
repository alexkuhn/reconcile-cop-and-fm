#!/usr/bin/env ruby

require_relative 'ImpliedExpression'

class ImpliedExpression < CompositeExpression

    def satisfied?
        expr1 = @expressions[0].satisfied?
        expr2 = @expressions[1].satisfied?
        (not expr1) or expr2
    end

    def to_s
        s = "implication:\n\t"
        @expressions.each do |expr|
            s += "#{expr}\n\t"
        end
        s
    end

end
