require 'test/unit'
require_relative '../classes/character'

class CharacterTest < Test::Unit::TestCase
    def setup
        @character = Character.new("John", "Dwarf", "Warrior")
    end
    
    def test_create
        assert_not_nil(@character)
    end

    def test_instance
        assert_equal('John', @character.name)
        assert_equal('Dwarf', @character.race)
        assert_equal('Warrior', @character.char_type)
    end
end


