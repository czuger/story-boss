require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @place = create(:place, story: @story )

    # Rubbish to be sure that we are not messing with other users
    bob = create(:user)
    @bobstory = create( :story, user: bob )
    @bobplace = create(:place, story: @bobstory )
  end

  test "should get index" do
    get story_places_url( @story )
    assert_response :success

    get story_places_url( @story, format: :json )
    # Ensuring that we get only one story (that we does not get bob story)
    assert_equal 1, JSON.parse( response.body ).count
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

  test "should not create for bob" do
    assert_raise do
      post story_place_url(@bobstory), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
    end
  end

  test "should show place" do
    get story_place_url(@story, @place)
    assert_response :success
  end

  test "should not show bob place" do
    assert_raise do
      get story_place_url(@bobstory, @bobplace)
      get story_place_url(@story, @bobplace)
      get story_place_url(@bobstory, @place)
    end
  end

  test "should get edit" do
    get edit_story_place_url(@story, @place)
    assert_response :success
  end

  test "should not edit bob place" do
    assert_raise do
      get edit_story_place_url(@bobstory, @bobplace)
      get edit_story_place_url(@story, @bobplace)
      get edit_story_place_url(@bobstory, @place)
    end
  end

  test "should update place" do
    patch story_place_url(@story, @place), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
    assert_redirected_to story_place_url(@story, @place)
  end

  test "should not update bob place" do
    assert_raise do
      patch story_place_url(@bobstory, @bobplace), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
      patch story_place_url(@story, @bobplace), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
      patch story_place_url(@bobstory, @place), params: { place: { ambiance: @place.ambiance, desc: @place.desc, name: @place.name } }
    end
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete story_place_url(@story, @place)
    end

    assert_redirected_to story_places_url(@story)
  end

  test "should not destroy bob place" do
    assert_raise do
      delete edit_story_place_url(@bobstory, @bobplace)
      delete edit_story_place_url(@story, @bobplace)
      delete edit_story_place_url(@bobstory, @place)
    end
  end

end
