#!/usr/bin/env ruby

class MappedActivatable

    attr_accessor :activatable
    
    def initialize(activatable)
		@activatable = activatable
	end
   
    def active?
        @activatable.active?
    end

end
