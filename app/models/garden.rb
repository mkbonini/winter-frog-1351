class Garden < ApplicationRecord
  has_many :plots

  def plant_list
    plots.joins(:plants)
    .select("plants.*")
    .where("days_to_harvest < 100" )
    .distinct
  end
end
