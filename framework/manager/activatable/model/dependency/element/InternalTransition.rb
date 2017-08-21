#!/usr/bin/env ruby

require_relative 'Transition'

class InternalTransition < Transition

    def initialize(category, activatable, node_state)
        super(category, activatable, node_state)
        @type = :internal_transition
    end

end
