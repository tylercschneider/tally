require "tally/version"
require "tally/engine"
require "tally/measure"
require "tally/rollup"
require "tally/recompute"

module Tally
  class << self
    def measures
      @measures ||= {}
    end

    def recompute(measure_name, facts, grain:, time:, by: [])
      Recompute.call(measure_name, facts, grain: grain, time: time, by: by)
    end

    def register_measure(name, aggregation:, field: nil)
      measures[name] = Measure.new(name: name, aggregation: aggregation, field: field)
    end

    def measure(name)
      measures.fetch(name)
    end

    def reset_measures!
      measures.clear
    end
  end
end
