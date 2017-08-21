#!/usr/bin/env ruby

require_relative 'Node'

class Transition < Node

    def initialize(category, activatable, active_state)
        super(category, activatable, active_state)
        @node_type = :transition
    end

    def fire
        if enabled?
            normal_arcs = input_normal_arcs
            normal_arcs.each do |a|
                a.input_node.tokens = a.input_node.tokens - a.weight
            end
            normal_arcs = output_normal_arcs
            normal_arcs.each do |a|
                a.output_node.tokens = a.output_node.tokens + a.weight
                a.output_node.warn_new_token if not input_normal_nodes.include?(a.output_node)
            end
        else
            raise Exception.new("cannot fire transition (not enabled):\n#{self}")
        end
    end

    def enabled?
        p1 = nil
        p2 = nil
        normal_arcs = input_normal_arcs
        inhibitor_arcs = input_inhibitor_arcs
        if not normal_arcs.nil?
            p1 = normal_arcs.find do |a|
                a.weight > a.input_node.tokens
            end
        end
        if not inhibitor_arcs.nil?
            p2 = inhibitor_arcs.find do |a|
                a.input_node.tokens > 0
            end
        end
        (p1.nil? and p2.nil?) ? true : false
    end

    def input_normal_arcs
        @input_arcs.find_all do |a|
            a.type == :normal_arc
        end
    end

    def input_inhibitor_arcs
        @input_arcs.find_all do |a|
            a.type == :inhibitor_arc
        end
    end

    def output_normal_arcs
        @output_arcs.find_all do |a|
            a.type == :normal_arc
        end
    end

    def output_inhibitor_arcs
        @output_arcs.find_all do |a|
            a.type == :inhibitor_arc
        end
    end

    def input_normal_nodes
        input_nodes = []
        input_normal_arcs.each do |a|
            input_nodes << a.input_node
        end
        input_nodes
    end

    def to_s
        "#{super}"
    end

end
