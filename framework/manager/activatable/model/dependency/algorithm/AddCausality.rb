#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddCausality < APNAlgorithm

    def apply_ext(activatables)
        a = activatables.at(0)
        b = activatables.at(1)

        added_elements = Array.new

        # t'
        it_prime = InternalTransition.new(:dependency, a, :deactivation)
        added_elements << it_prime

        # a --> t'
        @apn.elements.each do |e|
            if e.type == :activatable_place and e.activatable == a
                added_elements << NormalArc.new(:dependency, e, it_prime)
            end
        end

        # pr(!a) --> t'
        @apn.elements.each do |e|
            if e.type == :temporary_place and e.activatable == a and e.active_state == :deactivation
                added_elements << NormalArc.new(:dependency, e, it_prime)
            end
        end

        # b --o t'
        @apn.elements.each do |e|
            if e.type == :activatable_place and e.activatable == b
                added_elements << InhibitorArc.new(:dependency, e, it_prime)
            end
        end

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

        # pr(b)
        tp_act_b = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == b and e.active_state == :activation
        end

        # pr(!b)
        tp_deac_b = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == b and e.active_state == :deactivation
        end

        #       b --> deac(a)
        # deac(a) --> b
        # deac(a) --> pr(!b)
        @apn.elements.each do |e|
            if e.type == :internal_transition
                if e.input_normal_nodes.include?(ap_a)
                    if not e.output_normal_nodes.include?(ap_a)
                        if not e.input_inhibitor_nodes.include?(ap_b)
                            added_elements << NormalArc.new(:dependency, ap_b, e)
                            added_elements << NormalArc.new(:dependency, e, ap_b)
                            added_elements << NormalArc.new(:dependency, e, tp_deac_b)
                        end
                    end
                end
            end
        end
        # act(a) --> pr(b)
        @apn.elements.each do |e|
            if e.type == :internal_transition
                if e.output_normal_nodes.include?(ap_a)
                    if not e.input_normal_nodes.include?(ap_a)
                        added_elements << NormalArc.new(:dependency, e, tp_act_b)
                    end
                end
            end
        end

        @apn.elements.concat(added_elements)
    end

end