require 'rails_helper'

RSpec.describe 'garden show page' do
    it 'lists all the plants in a garden once' do
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
        PlotPlant.create!(plot: plot_2, plant: plant_4)

        visit garden_path(turing_garden)

        within "#plant-list" do
            expect(page).to have_content("squash",count: 1)
            expect(page).to have_content("peach",count: 1)
            expect(page).to_not have_content("carrot")
            expect(page).to_not have_content("apple")
        end
    end
end