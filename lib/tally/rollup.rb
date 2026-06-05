module Tally
  module Rollup
    def self.compute(facts, measure:, grain:, time:, by: [])
      definition = Tally.measure(measure)

      case definition.aggregation
      when :count then count(facts, grain: grain, time: time, by: by)
      when :sum then sum(facts, definition.field, grain: grain, time: time, by: by)
      else raise ArgumentError, "Unknown aggregation: #{definition.aggregation.inspect}"
      end
    end

    def self.count(facts, grain:, time:, by: [])
      grouped(facts, grain, time, by).transform_values(&:size)
    end

    def self.sum(facts, field, grain:, time:, by: [])
      grouped(facts, grain, time, by).transform_values do |group|
        group.sum { |fact| fact.public_send(field) }
      end
    end

    def self.grouped(facts, grain, time, by)
      facts.group_by { |fact| key(fact, grain, time, by) }
    end

    def self.key(fact, grain, time, by)
      bucket = bucket(fact.public_send(time), grain)
      return bucket if by.empty?

      [ bucket, *by.map { |dimension| fact.public_send(dimension) } ]
    end

    def self.bucket(moment, grain)
      moment.public_send("beginning_of_#{grain}")
    end
  end
end
