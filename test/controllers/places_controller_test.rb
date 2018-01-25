require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @place = create(:place, story: @story )

  end

  test "should get index" do
    get story_places_url( @story )
    assert_response :success
  end

  test "should get new" do
    get new_story_place_url( @story, @place )
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post story_places_url( @story ), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
    end

    assert_redirected_to story_place_url(@story, Place.last)
  end

  test "should show place" do
    get story_place_url(@story, @place)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_place_url(@story, @place)
    assert_response :success
  end

  test "should update place" do
    patch story_place_url(@story, @place), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
    assert_redirected_to story_place_url(@story, @place)
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete story_place_url(@story, @place)
    end

    assert_redirected_to story_places_url(@story)
  end
end
