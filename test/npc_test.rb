require 'test/unit'
require_relative '../classes/NPC'

class NPCTest < Test::Unit::TestCase
    def setup
        @npc = NPC.new('Nate', "Hi, I'm Nate", "Yes of course", "No")
    end

    def test_create
        assert_not_nil(@npc)
    end

    def test_instance
        assert_equal('Nate', @npc.name)
        assert_equal("Hi, I'm Nate", @npc.introduction)
        assert_equal('Yes of course', @npc.response_1)
        assert_equal("No", @npc.response_2)
    end

end