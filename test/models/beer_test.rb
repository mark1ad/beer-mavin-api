require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  def test_valid_create
    beer_name = "Nib Knot"
    beer = Beer.create({
      name: beer_name,
      brewery: "Jessup Farm Barrel House"
      })

    assert_equal beer_name, beer.name, "Beer name is wrong"
  end

  def test_missing_name
    beer = Beer.create({
      brewery: "Brewery"
      })
    assert !beer.valid?, "Missing name"
  end

  def test_missing_brewery
    beer = Beer.create({
      name: "Name"
      })

    assert !beer.valid?, "Missing brewery"
  end
end
