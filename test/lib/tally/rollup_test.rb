require "test_helper"

module Tally
  class RollupTest < ActiveSupport::TestCase
    Fact = Struct.new(:occurred_at, :amount, keyword_init: true)

    test "counts facts within a single time bucket" do
      facts = [
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 10)),
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 15))
      ]

      result = Rollup.count(facts, grain: :day, time: :occurred_at)

      assert_equal({ Time.utc(2026, 6, 1) => 2 }, result)
    end

    test "sums a measure field within a time bucket" do
      facts = [
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 10), amount: 100),
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 15), amount: 50)
      ]

      result = Rollup.sum(facts, :amount, grain: :day, time: :occurred_at)

      assert_equal({ Time.utc(2026, 6, 1) => 150 }, result)
    end
  end
end
