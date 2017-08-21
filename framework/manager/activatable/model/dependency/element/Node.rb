#!/usr/bin/env ruby

require_relative 'Element'

class Node < Element

    attr_accessor :activatable
    
    attr_accessor :input_arcs
    attr_accessor :output_arcs

    # e.g. of node_type = :transition
    attr_accessor :node_type

    # active_state = :activation or :deactivation
    attr_accessor :active_state

    def initialize(category, activatable, active_state)
        super(category)
        @activatable = activatable
        @input_arcs  = Array.new
        @output_arcs = Array.new
        @type = :node
        check_active_state(active_state)
        @active_state = active_state
    end

    def check_active_state(active_state)
        if active_state != :activation && active_state != :deactivation
            raise Exception.new('illegal \'active_state\' at the creation of a node')
        end
    end

    def add_input_arc(arc)
        @input_arcs << arc
    end

    def add_output_arc(arc)
        @output_arcs << arc
    end

    def remove_input_arc(arc)
        @input_arcs.delete(arc)
    end

    def remove_output_arc(arc)
        @output_arcs.delete(arc)
    end

    def remove_connectors
        @input_arcs = Array.new
        @output_arcs = Array.new
    end

    def input_normal_nodes
        nodes = Array.new
        @input_arcs.each do |arc|
            if arc.type == :normal_arc
                nodes << arc.input_node
            end
        end
        nodes
    end

    def output_normal_nodes
        nodes = Array.new
        @output_arcs.each do |arc|
            if arc.type == :normal_arc
                nodes << arc.output_node
            end
        end
        nodes
    end

    def input_inhibitor_nodes
        nodes = Array.new
        @input_arcs.each do |arc|
            if arc.type == :inhibitor_arc
                nodes << arc.input_node
            end
        end
        nodes
    end

    def warn_new_token
    end

    def to_s
        input_arcs_id  = Array.new
        output_arcs_id = Array.new
        input_arcs.each do |arc|
            input_arcs_id << arc.id
        end
        output_arcs.each do |arc|
            output_arcs_id << arc.id
        end

        "#{super}activatable: #{@activatable}\ninput_arcs_id: #{input_arcs_id}\noutput_arcs_id: #{output_arcs_id}\nnode_type: #{@node_type}\nactive_state: #{active_state}\n"
    end

end
