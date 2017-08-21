#!/usr/bin/env ruby

require_relative 'classes/ERS'
require_relative '../framework/Context'
require_relative '../framework/Feature'
require_relative '../framework/Activatable'

require_relative 'contexts/InitContexts'
require_relative 'features/InitFeatures'
require_relative 'mapping/InitMapping'
require_relative 'custom_composition/InitCustomComposition'

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

def print_ers
    puts "\n[alert]\n#{@ers.alert}\n"
    puts "[show]\n#{@ers.show}\n"
    puts "[inform]\n#{@ers.inform}\n"
    puts "[guide]\n#{@ers.guide}\n"
end

@step = 0

def continue
    if @step == 0
        puts "0.) Default state of the application."
    elsif @step == 1
        puts "1.) Activation of context Belgium and HighBattery."
        belgium      = Context.get(:belgium)
        high_battery = Context.get(:high_battery)
        Context.activate({:activation => [belgium, high_battery]})
    elsif @step == 2
        puts "2.) Activation of contexts Earthquake and InDanger."
        earthquake = Context.get(:earthquake)
        in_danger   = Context.get(:in_danger)
        earthquake.activate
        #Context.activate({:activation => [earthquake, in_danger]})
    elsif @step == 3
        puts "3.) Activation of context Wildfire and feature informSafePlaces."
        Context.get(:wildfire).activate
        Feature.get(:inform_safe_places).activate
    elsif @step == 4
        puts "4.) Activation of context LowBattery, and deactivation of feature guideUser."
        Context.get(:low_battery).activate
        Feature.get(:guide_user).deactivate
    end
    if @step <= 4
        @step += 1
        print_ers
        if @show_active
            show_all_active_contexts
            show_all_active_features
        end
        puts "\nPress Enter to continue (or CTRL-C to stop)."
        gets.chomp
        continue
    else
        puts "\nEnd of scenario"
    end
end

@ers = ERS.new

Feature.default.activate
Context.default.activate

continue

