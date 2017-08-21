#!/usr/bin/env ruby

require_relative 'Transition'

class ExternalTransition < Transition

    def initialize(category, activatable, active_state)
        super(category, activatable, active_state)
        @type = :external_transition
    end

end
