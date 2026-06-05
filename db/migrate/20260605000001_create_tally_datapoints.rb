class CreateTallyDatapoints < ActiveRecord::Migration[8.1]
  def change
    create_table :tally_datapoints do |t|
      t.string :measure, null: false
      t.string :grain, null: false
      t.datetime :period_start, null: false
      t.json :dimensions, null: false, default: {}
      t.decimal :value, null: false
      t.datetime :recomputed_at

      t.timestamps
    end

    add_index :tally_datapoints, [ :measure, :grain, :period_start ],
      name: "index_tally_datapoints_on_measure_grain_period"
  end
end
