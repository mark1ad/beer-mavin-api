require 'http'

class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :update, :destroy]

  # TODO: Zippy is for playing. Remove
  # POST /beers/zippy
  def zippy
    do_zippy
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

    # Example call to brewerydb.com. Gets information for Fat Tire
    def do_zippy
      puts "do_zippy"
      print params, "\n"
      beer_name = params["name"]
      puts "beer_name #{beer_name}"
      response = HTTP.get('http://api.brewerydb.com/v2/beers',
        :params=> {
          :key => ENV["BREWERYDB_BEERRATER_KEY"],
          :name => beer_name
        }
      )

      puts "\n************\n#{response.code}"
      puts "response #{response}"
      body = response.parse
      puts "body #{body}"

      # Check for success
      if body["status"] == "success"
        data = body["data"]
        render json: { status: 200, message: "Zippy!", data: data[0]}
      else
        render json: { status: 401, message: body["errorMessage"] }
      end
    end
end
