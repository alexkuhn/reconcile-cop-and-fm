#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddRequirement < APNAlgorithm

    def apply_ext(activatables)
        a = activatables.at(0)
        b = activatables.at(1)

        added_elements = Array.new

        # t'
        it_prime = InternalTransition.new(:dependency, a, :deactivation)
        added_elements << it_prime

        # a
        ap_a = @apn.elements.find do |e|
            e.type == :activatable_place and e.activatable == a
        end

        # b
        ap_b = @apn.elements.find do |e|
            e.type == :activatable_place and e.activatable == b
        end

        # pr(!a)
        tp_deac_a = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == a and e.active_state == :deactivation
        end

        # a  --> t'
        added_elements << NormalArc.new(:dependency, ap_a, it_prime)
        # t' --> a
        added_elements << NormalArc.new(:dependency, it_prime, ap_a)
        # t' --> pr(!a)
        added_elements << NormalArc.new(:dependency, it_prime, tp_deac_a)
        # b --o t'
        added_elements << InhibitorArc.new(:dependency, ap_b, it_prime)
        # pr(!a) --o t'
        added_elements << InhibitorArc.new(:dependency, tp_deac_a, it_prime)

        @apn.elements.concat(added_elements)
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


        # b --> act(a)
        # act(a) --> b
        @apn.elements.each do |e|
            if e.type == :internal_transition
                if e.output_normal_nodes.include?(ap_a)
                    if not e.input_normal_nodes.include?(ap_a)
                        added_elements << NormalArc.new(:dependency, ap_b, e)
                        added_elements << NormalArc.new(:dependency, e, ap_b)
                    end
                end
            end
        end

        @apn.elements.concat(added_elements)
    end

end
