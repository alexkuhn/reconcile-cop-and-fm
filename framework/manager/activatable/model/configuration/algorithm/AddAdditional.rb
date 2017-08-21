#!/usr/bin/env ruby

require_relative 'ADAlgorithm'

class AddAdditional < ADAlgorithm

    def apply(*args)
        apply_rec(*args)
    end

    def apply_rec(*args)
        expressions = []
        args.each do |arg|
            if arg.kind_of?(Array)
                expressions << apply_rec_array(arg)
            else
                expressions << BasicExpression.new(arg)
            end
        end
        expressions
    end

    def apply_rec_array(args)
        if args[0] == :implication
            expressions = []
            expressions.concat(apply_rec(args[1]))
            expressions.concat(apply_rec(args[2]))
            ImpliedExpression.new(expressions)
        elsif args[0] == :equivalence
            expressions = []
            expressions.concat(apply_rec(args[1]))
            expressions.concat(apply_rec(args[2]))
            EquivalentExpression.new(expressions)
        elsif args[0] == :conjunction
            expressions = []
            args.each_with_index do |arg, index|
                if index != 0
                    expressions.concat(apply_rec(arg))
                end
            end
            ConjunctiveExpression.new(expressions)
        elsif args[0] == :disjunction
            expressions = []
            args.each_with_index do |arg, index|
                if index != 0
                    expressions.concat(apply_rec(arg))
                end
            end
            DisjunctiveExpression.new(expressions)
        elsif args[0] == :negation
            expressions = apply_rec(args[1])
            NegativeExpression.new(expressions)
        end
    end

end
