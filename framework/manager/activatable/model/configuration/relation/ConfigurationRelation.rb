#!/usr/bin/env ruby

class ConfigurationRelation

    attr_accessor :type
    attr_accessor :activatables
    attr_accessor :expressions
    
    def initialize(type, *args, expressions)
		@type = type
        @activatables = retrieve_activatables(*args)
        @expressions  = expressions
	end

    def retrieve_activatables(*args)
        acts = []
        args.each_with_index do |arg, index|
            if index != 0
                acts << arg
            end
        end
        acts
    end

end
