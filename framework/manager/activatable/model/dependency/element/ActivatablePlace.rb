#!/usr/bin/env ruby

require_relative 'Place'

class ActivatablePlace < Place

    def initialize(category, activatable, active_state)
        super(category, activatable, active_state)
        @type = :activatable_place
    end

    def warn_new_token
        @activatable.update_continuation
    end

end
