#!/usr/bin/env ruby

class DependencyRelation

    attr_accessor :type
    attr_accessor :activatables
    
    def initialize(type, *activatables)
		@type = type
        @activatables = []
        activatables.each do |a|
            @activatables << a
        end
	end

end
