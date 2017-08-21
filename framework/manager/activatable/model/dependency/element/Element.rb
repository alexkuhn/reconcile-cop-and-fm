#!/usr/bin/env ruby

class Element

    class << self
        # bid = basic (element) id
        # did = dependency (element) id
        attr_accessor :last_bid
        attr_accessor :last_did

        def next_bid
            @last_bid += 1
            "b#{@last_bid}".to_sym
        end

        def next_did
            @last_did += 1
            "d#{@last_did}".to_sym
        end

        def reset_did
            @last_did = 0
        end

    end

    Element.last_bid = 0
    Element.last_did = 0

    attr_accessor :id
    # category = :basic or :dependency
    attr_accessor :category
    # e.g. of type = :internal_transition
    attr_accessor :type

    def initialize(category)
        @category = category
        if @category == :basic
            @id = Element.next_bid
        else # :dependency
            @id = Element.next_did
        end
    end

    def remove_connectors
    end

    def to_s
        "\nid: #{@id}\ntype: #{type}\n"
    end

end
