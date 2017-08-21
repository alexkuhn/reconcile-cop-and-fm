#!/usr/bin/env ruby

require_relative 'ADAlgorithm'

class AddMandatory < ADAlgorithm

    def apply(*args)
        parent = args[0]
        child  = args[1]
        p = BasicExpression.new(parent)
        c = BasicExpression.new(child)
        
        [EquivalentExpression.new([p, c])]
    end

end
