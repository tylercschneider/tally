class AddDimensionsKeyToTallyDatapoints < ActiveRecord::Migration[8.1]
  def change
    add_column :tally_datapoints, :dimensions_key, :string, null: false, default: ""

    remove_index :tally_datapoints, name: "index_tally_datapoints_on_measure_grain_period"
    add_index :tally_datapoints, %i[measure grain period_start dimensions_key],
      unique: true, name: "index_tally_datapoints_unique"
  end
end
