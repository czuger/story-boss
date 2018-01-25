require 'test_helper'

class PlotsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @plot = create(:plot, story: @story )

    # Rubbish to be sure that we are not messing with other users
    bob = create(:user)
    @bobstory = create( :story, user: bob )
    @bobplot = create(:plot, story: @bobstory )
  end

  test "should get index" do
    get story_plots_url( @story )
    assert_response :success

    get story_plots_url( @story, format: :json )
    # Ensuring that we get only one story (that we does not get bob story)
    assert_equal 1, JSON.parse( response.body ).count
  end

  test "should get new" do
    get new_story_plot_url( @story )
    assert_response :success
  end

  test "should create plot" do
    assert_difference('Plot.count') do
      post story_plots_url( @story ), params: { plot: { desc: @plot.desc, name: @plot.name, story_id: @plot.story_id } }
    end

    assert_redirected_to story_plot_url(@story, Plot.last)
  end

  test "should not create bob plot" do
    assert_raise do
      post story_plots_url(@bobstory), params: { plot: { desc: @plot.desc, name: @plot.name, story_id: @plot.story_id } }
    end
  end

  test "should show plot" do
    get story_plot_url(@story, @plot)
    assert_response :success
  end

  test "should not show bob plot" do
    assert_raise do
      get story_plots_url(@bobstory, @bobplot)
      get story_plots_url(@story, @bobplot)
      get story_plots_url(@bobstory, @place)
    end
  end

  test "should get edit" do
    get edit_story_plot_url(@story, @plot)
    assert_response :success
  end

  test "should update plot" do
    patch story_plot_url(@story, @plot), params: { plot: { desc: @plot.desc, name: @plot.name, story_id: @plot.story_id } }
    assert_redirected_to story_plot_url(@story, @plot)
  end

  test "should not update bob plot" do
    assert_raise do
      patch story_plots_url(@bobstory), params: { plot: { desc: @plot.desc, name: @plot.name, story_id: @plot.story_id } }
    end
  end

  test "should destroy plot" do
    assert_difference('Plot.count', -1) do
      delete story_plot_url(@story, @plot)
    end

    assert_redirected_to story_plots_url(@story)
  end

  test "should not destroy bob plot" do
    assert_raise do
      delete story_plots_url(@bobstory, @bobplot)
      delete story_plots_url(@story, @bobplot)
      delete story_plots_url(@bobstory, @place)
    end
  end
end
