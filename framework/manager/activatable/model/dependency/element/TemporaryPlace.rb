#!/usr/bin/env ruby

require_relative 'Place'

class TemporaryPlace < Place

    def initialize(category, activatable, active_state)
        super(category, activatable, active_state)
        @type = :temporary_place
    end

end
