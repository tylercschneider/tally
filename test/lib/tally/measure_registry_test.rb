require "test_helper"

module Tally
  class MeasureRegistryTest < ActiveSupport::TestCase
    teardown do
      Tally.reset_measures!
    end

    test "registers and looks up a measure by name" do
      Tally.register_measure(:revenue, aggregation: :sum, field: :amount)

      assert_equal :sum, Tally.measure(:revenue).aggregation
    end
  end
end
