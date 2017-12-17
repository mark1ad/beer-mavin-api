require 'http'

class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :update, :destroy]

  # GET /beers/search
  def search
    find_beers
  end

  # GET /beers/by_id
  # Get beer information using brewerydb.com id
  def by_id
    get_beer
  end

  # GET /beers
  def index
    @beers = Beer.all

    render json: @beers
  end

  # GET /beers/1
  def show
    render json: @beer
  end

  # POST /beers
  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      render json: @beer, status: :created, location: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beers/1
  def update
    if @beer.update(beer_params)
      render json: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beers/1
  def destroy
    @beer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def beer_params
      params.require(:beer).permit(:name, :brewery)
    end

    # get a beer from brewerydb.com using the beer's id
    def get_beer
      beer_id = params['id'];
      response = HTTP.get('http://api.brewerydb.com/v2/beer/' + beer_id,
        :params=> {
          :key => ENV["BREWERYDB_BEERRATER_KEY"],
          :withBreweries => "y"
        }
      )

      body = response.parse

      # check for success
      if body["status"] == "success"
        data = body["data"]
        unless data.nil?
          render json: {
            status: 200,
            message: "#{params['id']} found",
            data: data}
        else
          render json: {
            status: 200,
            message: "#{params['id']} not found",
            data: []
          }
        end
      else
        render json: { status: 401, message: body["errorMessage"]}
      end
    end

    # Searches for beers on brewerydb.com
    def find_beers
      # Use wild cards to get any beer with search string in name
      beer_name = "*#{params['name']}*"
      response = HTTP.get('http://api.brewerydb.com/v2/beers',
        :params=> {
          :key => ENV["BREWERYDB_BEERRATER_KEY"],
          :name => beer_name,
          :withBreweries => "y"
        }
      )

      body = response.parse

      # check for success
      if body["status"] == "success"
        data = body["data"]
        unless data.nil?
          render json: { status: 200, message: "#{params['name']} found", data: data}
        else
          render json: {
            status: 200,
            message: "#{params['name']} not found",
            data: []}
        end
      else
        render json: { status: 401, message: body["errorMessage"] }
      end
    end
end
