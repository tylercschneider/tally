require "test_helper"

module Tally
  class RecomputeTest < ActiveSupport::TestCase
    Fact = Struct.new(:occurred_at, :amount, :channel, keyword_init: true)

    teardown do
      Tally.reset_measures!
    end

    test "persists a rollup datapoint" do
      Tally.register_measure(:revenue, aggregation: :sum, field: :amount)
      facts = [
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 10), amount: 100),
        Fact.new(occurred_at: Time.utc(2026, 6, 1, 15), amount: 50)
      ]

      Tally.recompute(:revenue, facts, grain: :day, time: :occurred_at)

      assert_equal 150, Datapoint.sole.value
    end
  end
end
