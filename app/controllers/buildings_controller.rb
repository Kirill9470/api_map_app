class BuildingsController < ApplicationController
  before_action :set_building, except: [:index, :create]

  def index
    @buildings = Building.filter_by_coordinates(params[:coordinates], params[:distanse])
  end

  def create
    @building = Building.new(building_params)
    respond_to do |format|
      if @building.save
        format.json {render json: {message: 'Здание успешно добавлено'}, status: :ok }
      else
        format.json {render json: {data: @building.errors.full_messages.join("\n"), message: 'Ошибка'}, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @building.update(building_params)
        format.json {render json: {message: 'Здание успешно обновлено'}, status: :ok }
      else
        format.json {render json: {data: @building.errors.full_messages.join("\n"), message: 'Ошибка'}, status: :unprocessable_entity}
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
    params.require(:building).permit(:name, :address, :latitude, :longitude)
  end

  def set_building
    @building = Building.find(params[:id])
  end

end