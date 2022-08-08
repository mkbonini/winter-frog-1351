class PlotPlantsController < ApplicationController
    def destroy
        plot_plant = PlotPlant.where(plot_id: params[:id], plant_id: params[:format])
        PlotPlant.delete(plot_plant.first.id)
        redirect_to plots_path
    end
end