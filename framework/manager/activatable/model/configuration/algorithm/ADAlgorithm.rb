#!/usr/bin/env ruby

require_relative '../expression/BasicExpression'
require_relative '../expression/NegativeExpression'
require_relative '../expression/ConjunctiveExpression'
require_relative '../expression/DisjunctiveExpression'
require_relative '../expression/EquivalentExpression'
require_relative '../expression/ImpliedExpression'

class ADAlgorithm

    attr_accessor :ad

    def initialize(ad)
        @ad = ad
    end

    def apply
    end

end
