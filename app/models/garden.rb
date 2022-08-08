class Garden < ApplicationRecord
  has_many :plots

  def plant_list
    plots.joins(:plants)
    .select("plants.*, count(plants.name) as plant_count")
    .group('plants.id')
    .order('plant_count desc')
    .where("days_to_harvest < 100" )
    .distinct
  end
end
