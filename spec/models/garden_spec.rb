require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    it 'plant_list should list unique plants in garden' do
      turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

      plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
      plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")

      plant_1 = Plant.create!(name: 'squash', description: 'a tasty veg', days_to_harvest: 25)
      plant_2 = Plant.create!(name: 'peach', description: 'a tasty fruit', days_to_harvest: 50)
      plant_3 = Plant.create!(name: 'carrot', description: 'an orange veg', days_to_harvest: 30)
      plant_4 = Plant.create!(name: 'apple', description: 'fruit from a tree', days_to_harvest: 150)

      PlotPlant.create!(plot: plot_1, plant: plant_1)
      PlotPlant.create!(plot: plot_1, plant: plant_2)
      PlotPlant.create!(plot: plot_2, plant: plant_1)

      plants = turing_garden.plant_list

      expect(plants.first.name).to eq('squash')
      expect(plants.second.name).to eq('peach')
    end

    it 'plant_list orders by frequency' do
      turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

        plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        plot_3 = turing_garden.plots.create!(number: 27, size: "Small", direction: "east north-east")

        plant_3 = Plant.create!(name: 'carrot', description: 'an orange veg', days_to_harvest: 30)
        plant_2 = Plant.create!(name: 'peach', description: 'a tasty fruit', days_to_harvest: 50)
        plant_1 = Plant.create!(name: 'squash', description: 'a tasty veg', days_to_harvest: 25)
        

        PlotPlant.create!(plot: plot_1, plant: plant_1)
        PlotPlant.create!(plot: plot_1, plant: plant_2)
        PlotPlant.create!(plot: plot_2, plant: plant_1)
        PlotPlant.create!(plot: plot_2, plant: plant_2)
        PlotPlant.create!(plot: plot_3, plant: plant_1)
        PlotPlant.create!(plot: plot_3, plant: plant_3)

        plants = turing_garden.plant_list

        expect(plants.first.name).to eq('squash')
        expect(plants.second.name).to eq('peach')
        expect(plants.last.name).to eq('carrot')
    end
  end
end
