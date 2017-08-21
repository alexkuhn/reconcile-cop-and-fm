#!/usr/bin/env ruby

class ConflictStrategy

    attr_accessor :model
    attr_accessor :requests

    def initialize(model)
        @model = model
        @requests = {}
	end

    def set_requests(requests)
        @requests = requests
    end

    def resolve_conflicts
        cs = @model.get_conflicts
        if not cs.empty?
            if can_attempt_alternative?(cs)
                attempt_alternative(cs)
            else
                rollback
            end
        end
    end

    def can_attempt_alternative?(conflicts)
        not find_attempt_alternative_conflict(conflicts).nil?
    end

    def attempt_alternative(conflicts)
        other_act = find_attempt_alternative_conflict(conflicts)
        @model.activate({:deactivation => [other_act]})
    end

    def rollback
        revert_requests = {}
        if @requests.has_key? :activation
            revert_requests[:deactivation] = @requests[:activation]
        end
        if @requests.has_key? :deactivation
            revert_requests[:activation] = @requests[:deactivation]
        end
        @model.activate(revert_requests)
    end

    def find_attempt_alternative_conflict(cs)
        if cs.has_key? :dependency
            cs[:dependency].each do |dep_cs|
                conflicted_act = dep_cs.activatable
                dep_relations = @model.find_dependency_relations_with(:exclusion, conflicted_act)
                con_relations = @model.find_configuration_relations_with(:alternative, conflicted_act)
                
                # find a conflict that follows the pattern of attempt_alternative:
                # - 'conflicted_act' cannot become active
                # - there's another activatable that is active,
                #   has an exclusion and an alternative relation
                #   with 'conflicted_act'
                #
                #   found if dep_act == con_act
                dep_relations.each do |dep_rel|
                    dep_rel.activatables.each do |dep_act|
                        if dep_act != conflicted_act and dep_act.active?
                            con_relations.each do |con_rel|
                                con_rel.activatables.each do |con_act|
                                    if dep_act == con_act
                                        return dep_act
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

end
