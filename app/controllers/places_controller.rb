class PlacesController < ApplicationController
# tämä rivi tarvitaan jotta api toimii herokussa ja tarvisissa
  require 'beermapping_api.rb'

    def index
    end

    def search
      # cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 1.week)

      @places = BeermappingApi.places_in(params[:city])
      if @places.nil?
        # if @places.nil?   should be:   if @places.empty?
        redirect_to places_path, method: :search, notice: "Search: No beer places in #{params[:city]}"
      else
        session[:last_city] = params[:city]
        render :index
      end
    end

  def show

    if BeermappingApi.place_in(params[:id], session[:last_city]).nil?
      redirect_to places_path, method: :search, notice: "No beer places in #{session[:last_city]}"
    else
      @place = BeermappingApi.place_in(params[:id], session[:last_city])
    end
  end

  # private
  # # Use callbacks to share common setup or constraints between actions.
  # def set_place
  #   @place = Place.find(params[:id])
  # end
  # # Never trust parameters from the scary internet, only allow the white list through.
  # def place_params
  #   params.require(:place).permit(:id)
  # end
   end
