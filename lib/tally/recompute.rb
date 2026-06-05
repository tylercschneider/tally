module Tally
  module Recompute
    def self.call(measure_name, facts, grain:, time:, by: [])
      result = Rollup.compute(facts, measure: measure_name, grain: grain, time: time, by: by)

      result.each do |key, value|
        period_start, dimensions = decompose(key, by)
        datapoint = Datapoint.find_or_initialize_by(
          measure: measure_name.to_s,
          grain: grain.to_s,
          period_start: period_start,
          dimensions: dimensions
        )
        datapoint.update!(value: value)
      end
    end

    def self.decompose(key, by)
      return [ key, {} ] if by.empty?

      period_start, *dimension_values = key
      [ period_start, by.map(&:to_s).zip(dimension_values).to_h ]
    end
  end
end
