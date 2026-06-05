require "json"

module Tally
  class Datapoint < ApplicationRecord
    self.table_name = "tally_datapoints"

    scope :in_period, ->(range) { where(period_start: range) }

    before_validation :assign_dimensions_key

    # A canonical, order-independent string for a dimensions hash, used to match
    # and uniquely index rows. Avoids relying on JSON column equality, which
    # Postgres's `json` type does not support.
    def self.dimensions_key_for(dimensions)
      (dimensions || {}).to_a.sort.to_h.to_json
    end

    private

    def assign_dimensions_key
      self.dimensions_key = self.class.dimensions_key_for(dimensions)
    end
  end
end
