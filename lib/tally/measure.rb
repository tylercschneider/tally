module Tally
  Measure = Struct.new(:name, :aggregation, :field, keyword_init: true)
end
