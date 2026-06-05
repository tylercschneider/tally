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

    test "stamps recomputed_at" do
      Tally.register_measure(:orders, aggregation: :count)

      Tally.recompute(:orders, [ Fact.new(occurred_at: Time.utc(2026, 6, 1, 10)) ], grain: :day, time: :occurred_at)

      assert_not_nil Datapoint.sole.recomputed_at
    end

    test "re-running recompute upserts in place without duplicating" do
      Tally.register_measure(:revenue, aggregation: :sum, field: :amount)
      facts = [ Fact.new(occurred_at: Time.utc(2026, 6, 1, 10), amount: 100) ]

      2.times { Tally.recompute(:revenue, facts, grain: :day, time: :occurred_at) }

      assert_equal 1, Datapoint.count
    end
  end
end
