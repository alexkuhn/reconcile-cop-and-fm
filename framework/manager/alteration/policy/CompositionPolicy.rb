#!/usr/bin/env ruby

class CompositionPolicy

    attr_accessor :custom_orders

    def initialize
        @custom_orders = []
    end

    def do_sort(alterations)
        chain1 = global_sort(alterations)
        chain2 = custom_sort(chain1)
        chain2
    end

    def global_sort(alterations)
        chain = []
        alterations.each do |a|
            insert_by_feat_age(chain, a)
        end
        chain
    end

    def custom_sort(alterations)
        copy = alterations.clone
        @custom_orders.each do |custom_order|
            feat_name1 = custom_order[0]
            feat_name2 = custom_order[1]
            alterations.each do |a1|
                alterations.each do |a2|
                    if (a1 != a2) and
                        (a1.feature.name == feat_name1) and
                        (a2.feature.name == feat_name2) and
                        (copy.index(a1) > copy.index(a2))
                            move_before_index(copy, a1, a2)
                    end
                end
            end
        end
        copy
    end

    def insert_by_feat_age(chain, a)
        # find index of youngest among older
        # from a, in the chain
        index = chain.size
        chain.each_with_index do |alt, alt_index|
            if alt.feature_age > a.feature_age and alt_index < index
                index = alt_index
            end
        end
        chain.insert(index, a)
    end

    def move_before_index(alterations, a1, a2)
        # move a1 before a2 in alterations
        index_a2 = alterations.index(a2)
        alterations.delete(a1)
        alterations.insert(index_a2, a1)
    end

    def set_custom_order(feat1, feat2)
        @custom_orders << [feat1, feat2]
    end

    def print_chain(alterations)
        alterations.each do |a|
            puts a.feature.name
        end
        puts ""
    end

end
