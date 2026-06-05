module Tally
  module Rollup
    def self.count(facts, grain:, time:)
      facts.group_by { |fact| bucket(fact.public_send(time), grain) }
           .transform_values(&:size)
    end

    def self.bucket(moment, grain)
      moment.public_send("beginning_of_#{grain}")
    end
  end
end
