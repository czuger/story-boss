require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )

    # Rubbish to be sure that we are not messing with other users
    bob = create(:user)
    @bobstory = create( :story, user: bob )
  end

  test "should get index" do
    get stories_url
    assert_response :success

    get stories_url( format: :json )
    # Ensuring that we get only one story (that we does not get bob story)
    assert_equal 1, JSON.parse( response.body ).count
  end

  test "should get new" do
    get new_story_url
    assert_response :success
  end

  test "should create story" do
    assert_difference('Story.count') do
      post stories_url, params: { story: { desc: @story.desc, name: @story.name } }
    end

    assert_redirected_to story_url(Story.last)
  end

  test "should show story" do
    get story_url(@story)
    assert_response :success
  end

  test "should not show bob story" do
    assert_raise do
      get story_url(@bobstory)
    end
  end

  test "should get edit" do
    get edit_story_url(@story)
    assert_response :success
  end

  test "should not edit bob story" do
    assert_raise do
      get edit_story_url(@bobstory)
    end
  end

  test "should update story" do
    patch story_url(@story), params: { story: { desc: @story.desc, name: @story.name } }
    assert_redirected_to story_url(@story)
  end

  test "should not update bob story" do
    assert_raise do
      patch story_url(@bobstory)
    end
  end

  test "should destroy story" do
    assert_difference('Story.count', -1) do
      delete story_url(@story)
    end

    assert_redirected_to stories_url
  end

  test "should not destroy bob story" do
    assert_raise do
      delete story_url(@bobstory)
    end
  end
end
