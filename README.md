# Tally

A **source-agnostic aggregation engine**. Feed it facts — rows with dimensions and
measurable values — and it turns them into numbers: declared **measures**, rolled up
by **time grain** and **dimension**, recomputed idempotently.

Tally depends on no particular data source. It doesn't know about events, an outbox,
or any specific producer — anything that can hand it facts can use it. (In the
EventEngine stack, an adapter feeds `event_engine-store` events in as facts; but
that adapter lives elsewhere, not here.)

## Installation

```ruby
gem "tally"
```

```bash
$ bundle
```

## Status

Early development. The first rollup works — `Tally::Rollup.count` / `.sum` aggregate
facts by **time grain** and optional **dimensions**:

```ruby
Tally::Rollup.count(facts, grain: :day, time: :occurred_at)
Tally::Rollup.sum(facts, :amount, grain: :day, time: :occurred_at, by: [:channel])
```

Declare named **measures** once and compute by name:

```ruby
Tally.register_measure(:revenue, aggregation: :sum, field: :amount)
Tally::Rollup.compute(facts, measure: :revenue, grain: :day, time: :occurred_at)
```

Persist rollups idempotently into the `tally_datapoints` table:

```ruby
Tally.recompute(:revenue, facts, grain: :day, time: :occurred_at, by: [:channel])
# upserts one Tally::Datapoint per (measure, grain, period_start, dimensions);
# re-running updates values in place — no duplicates.
```

Next: a recompute job + window scoping, then sketches/cohorts.

## License

Available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
