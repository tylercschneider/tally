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

Early development — building the measure registry and the first rollup.

## License

Available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
