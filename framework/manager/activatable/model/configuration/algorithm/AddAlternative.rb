#!/usr/bin/env ruby

require_relative 'ADAlgorithm'

class AddAlternative < ADAlgorithm

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
        children.each do |ci|
            res << ImpliedExpression.new([ci, p])
            children.each do |cj|
                if ci != cj
                    res << ImpliedExpression.new([ci, NegativeExpression.new([cj])])
                end
            end
        end

        res
    end

end
