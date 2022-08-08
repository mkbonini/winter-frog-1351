class CreatePlotPlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plot_plants do |t|
      t.references :plots, foreign_key: true
      t.references :plants, foreign_key: true

      t.timestamps
    end
  end
end
