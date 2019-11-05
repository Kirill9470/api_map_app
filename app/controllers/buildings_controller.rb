class BuildingsController < ApplicationController
  before_action :set_building, except: [:index, :create]

  def index
    @buildings = Building.filter_by_coordinates(params[:coordinates], params[:distance])
  end

  def create
    @building = Building.new(building_params)
    respond_to do |format|
      if @building.save
        format.json {render json: {message: 'Здание успешно добавлено'}, status: :ok }
      else
        format.json {render json: {data: @building.errors.messages, message: 'Ошибка'}, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @building.destroy
    respond_to do |format|
      format.json {render json: {message: 'Здание успешно удалено'}, status: :ok }
    end
  end

  private

  def building_params
    params.require(:building).permit(:house, :street)
  end

  def set_building
    @building = Building.find(params[:id])
  end

end