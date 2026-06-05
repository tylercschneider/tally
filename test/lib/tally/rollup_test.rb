require "test_helper"

module Tally
  class RollupTest < ActiveSupport::TestCase
    Fact = Struct.new(:occurred_at, keyword_init: true)

    test "counts facts within a single time bucket" do
      facts = [
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 10)),
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 15))
      ]

      result = Rollup.count(facts, grain: :day, time: :occurred_at)

      assert_equal({ Time.utc(2026, 6, 1) => 2 }, result)
    end
  end
end
