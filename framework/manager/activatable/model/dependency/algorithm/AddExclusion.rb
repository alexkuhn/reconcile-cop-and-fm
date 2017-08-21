#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddExclusion < APNAlgorithm

    def apply_ext(activatables)
        # no extension
    end

    def apply_cons(activatables)
        a = activatables.at(0)
        b = activatables.at(1)

        added_elements = Array.new

        # a
        ap_a = @apn.elements.find do |e|
            e.type == :activatable_place and e.activatable == a
        end

        # b
        ap_b = @apn.elements.find do |e|
            e.type == :activatable_place and e.activatable == b
        end

        # a --o act(b)
        # b --o act(a)
        @apn.elements.each do |e|
            if e.type == :internal_transition
                if e.output_normal_nodes.include?(ap_a)
                    if not e.input_normal_nodes.include?(ap_a)
                        added_elements << InhibitorArc.new(:dependency, ap_b, e)
                    end
                end
                if e.output_normal_nodes.include?(ap_b)
                    if not e.input_normal_nodes.include?(ap_b)
                        added_elements << InhibitorArc.new(:dependency, ap_a, e)
                    end
                end
            end
        end

        @apn.elements.concat(added_elements)
    end

end
