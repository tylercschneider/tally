module Tally
  module Rollup
    def self.count(facts, grain:, time:)
      grouped(facts, grain, time).transform_values(&:size)
    end

    def self.sum(facts, field, grain:, time:)
      grouped(facts, grain, time).transform_values do |group|
        group.sum { |fact| fact.public_send(field) }
      end
    end

    def self.grouped(facts, grain, time)
      facts.group_by { |fact| bucket(fact.public_send(time), grain) }
    end

    def self.bucket(moment, grain)
      moment.public_send("beginning_of_#{grain}")
    end
  end
end
