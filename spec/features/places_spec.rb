require 'rails_helper'
require 'beermapping_api'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

it "if many are returned by the API, all are shown at the page" do
  allow(BeermappingApi).to receive(:places_in).with("kamppi").and_return(
      [
          Place.new( name:"Sea Horse", id: 1 ),
          Place.new( name:"Carousel", id: 2 ),
          Place.new( name:"Black Cat", id: 3 )
      ]
  )

  visit places_path
  fill_in('city', with: 'kamppi')
  click_button "Search"

  expect(page).to have_content "Sea Horse"
  expect(page).to have_content "Carousel"
  expect(page).to have_content "Black Cat"
end

it "if none is returned by the API, user is informed" do
  allow(BeermappingApi).to receive(:places_in).with("Lauttasaari").and_return(
      [ ]
  )

  visit places_path
  fill_in('city', with: 'Lauttasaari')
  click_button "Search"

  expect(page).to have_content "No locations in Lauttasaari"
end
end