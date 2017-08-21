#!/usr/bin/env ruby

require_relative '../framework/Context'
require_relative '../framework/Feature'
require_relative '../framework/Activatable'

@show_active = true # set to true to show active contexts and features

def show_all_active_contexts
    s = "\n\tActive Contexts:\n\t\t"
    Context.get_all_active.each do |ctx|
        s += "#{ctx.name}\n\t\t"
    end
    puts s
end

def show_all_active_features
    s = "\n\tActive Features:\n\t\t"
    Feature.get_all_active.each do |feat|
        s += "#{feat.name}\n\t\t"
    end
    puts s
end


Feature.default.activate
Context.default.activate


