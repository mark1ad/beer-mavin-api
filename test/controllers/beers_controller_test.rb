require 'test_helper'

class BeersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beer = beers(:fat_tire)
  end

  test "create without name" do
    assert_no_difference('Beer.count') do
      post beers_url, params: { beer: { brewery: @beer.brewery } }, as: :json
    end

    assert_response 422
  end

  def test_create_without_brewery
    assert_no_difference('Beer.count') do
      post beers_url, params: { beer: { name: @beer.name } }, as: :json
    end

    assert_response 422
  end

  test "should get index" do
    get beers_url, as: :json
    assert_response :success
  end

  test "should create beer" do
    assert_difference('Beer.count') do
      post beers_url, params: { beer: { brewery: @beer.brewery, name: @beer.name } }, as: :json
    end

    assert_response 201
  end

  test "should show beer" do
    get beer_url(@beer), as: :json
    assert_response :success
  end

  test "should update beer" do
    patch beer_url(@beer), params: { beer: { brewery: @beer.brewery, name: @beer.name } }, as: :json
    assert_response 200
  end

  test "should destroy beer" do
    assert_difference('Beer.count', -1) do
      delete beer_url(@beer), as: :json
    end

    assert_response 204
  end
end
