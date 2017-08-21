#!/usr/bin/env ruby

require_relative 'ADAlgorithm'

class AddOptional < ADAlgorithm

    def apply(*args)
        parent = args[0]
        child  = args[1]
        p = BasicExpression.new(parent)
        c = BasicExpression.new(child)
        
        [ImpliedExpression.new([c, p])]
    end

end
