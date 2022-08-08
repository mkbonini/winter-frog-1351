class Garden < ApplicationRecord
  has_many :plots

  def plant_list
    plots.joins(:plants)
    .select("plants.*")
    .distinct
  end
end
