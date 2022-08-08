require 'rails_helper'

RSpec.describe 'plots index page' do
    it 'displays all the plots with their plants' do
        turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
        library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
        other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

        plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        plot_3 = library_garden.plots.create!(number: 2, size: "Small", direction: "South")
        plot_4 = other_garden.plots.create!(number: 738, size: "Medium", direction: "West")

        plant_1 = Plant.create!(name: 'squash', description: 'a tasty veg', days_to_harvest: 25)
        plant_2 = Plant.create!(name: 'peach', description: 'a tasty fruit', days_to_harvest: 50)
        plant_3 = Plant.create!(name: 'carrot', description: 'an orange veg', days_to_harvest: 125)

        PlotPlant.create!(plot: plot_1, plant: plant_1)
        PlotPlant.create!(plot: plot_1, plant: plant_2)
        PlotPlant.create!(plot: plot_2, plant: plant_1)

        visit plots_path

        within "#plots-list" do
            expect(page).to have_content("Plot Number: 25")
            expect(page).to have_content("Plot Number: 26")
            expect(page).to have_content("Plot Number: 2")
            expect(page).to have_content("Plot Number: 738")
        end

        within "#plot25-plants" do
            expect(page).to have_content("squash")
            expect(page).to have_content("peach")
        end

        within "#plot26-plants" do
            expect(page).to have_content("squash")
        end

        expect(page).to_not have_content("carrot")
    end

    it 'has a link to remove a plant from plot' do
        turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
        plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
        plant_1 = Plant.create!(name: 'squash', description: 'a tasty veg', days_to_harvest: 25)
        plant_2 = Plant.create!(name: 'peach', description: 'a tasty fruit', days_to_harvest: 50)
        PlotPlant.create!(plot: plot_1, plant: plant_1)
        PlotPlant.create!(plot: plot_1, plant: plant_2)
        PlotPlant.create!(plot: plot_2, plant: plant_1)

        visit plots_path

        within "#plot25-plants" do
            first(:link, "Remove From Plot").click
            expect(page).to have_content("peach")
            expect(page).to_not have_content("squash")
        end


        within "#plot26-plants" do
            expect(page).to have_content("squash")
        end
    end
end