require 'test/unit'
require_relative '../classes/map'

class MapTest < Test::Unit::TestCase
    def setup
        @map = Map.new('Fernsworth', ['John', 'James', 'Henry'])
    end

    def test_create
        assert_not_nil(@map)
    end

    def test_instance
        assert_equal('Fernsworth', @map.name)
        assert_equal(['John', 'James', 'Henry'], @map.npcs)
    end
end