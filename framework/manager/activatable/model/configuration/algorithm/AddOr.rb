#!/usr/bin/env ruby

require_relative 'ADAlgorithm'

class AddOr < ADAlgorithm

    def apply(*args)
        parent = args[0]
        p = BasicExpression.new(parent)
        
        children = []
        args.each_with_index do |child, index|
            if index != 0
                children << BasicExpression.new(child)
            end
        end
        disj = DisjunctiveExpression.new(children)

        res = []
        res << ImpliedExpression.new([p, disj])
        children.each do |c|
            res << ImpliedExpression.new([c, p])
        end

        res
    end

end
