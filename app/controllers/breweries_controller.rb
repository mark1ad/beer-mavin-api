class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :update, :destroy]

  # GET /breweries
  def index
    @breweries = Brewery.all

    render json: @breweries
  end

  # GET /breweries/by_id
  # GET brewery information using brewerydb.com id
  def by_id
    get_brewery
  end

  # GET /breweries/1
  def show
    render json: @brewery
  end

  # POST /breweries
  def create
    @brewery = Brewery.new(brewery_params)

    if @brewery.save
      render json: @brewery, status: :created, location: @brewery
    else
      render json: @brewery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /breweries/1
  def update
    if @brewery.update(brewery_params)
      render json: @brewery
    else
      render json: @brewery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /breweries/1
  def destroy
    @brewery.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brewery_params
      params.require(:brewery).permit(:name, :brewerydbid)
    end

    def get_brewery
      brewery_id = params['id'];
      response = HTTP.get('http://api.brewerydb.com/v2/brewery/' + brewery_id,
        :params=> {
          :key => ENV["BREWERYDB_BEERRATER_KEY"]
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
            data: data
          }
        else
          render json: {
            status: 200,
            message: "#{params['id']} not found",
            data: {}
          }
        end
      else
        render json: {
          status: 401,
          message: body["errorMessage"]
        }
      end
    end
end
