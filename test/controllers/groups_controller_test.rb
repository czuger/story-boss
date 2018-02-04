require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @group = create( :group, story: @story )

    c1 = create( :character, story: @story )
    @c2 = create( :character, story: @story )
    @goodcharacters = { c1.id => 'false', @c2.id => 'true' }

    # Rubbish to be sure that we are not messing with other users
    bob = create(:user)
    @bobstory = create( :story, user: bob )
    @bobgroup = create(:group, story: @bobstory, name: 'bob group' )

    @c3 = create( :character, story: @bobstory )
  end

  test "should get index" do
    get story_groups_url(@story)
    assert_response :success

    get story_groups_url( @story, format: :json )
    # Ensuring that we get only one story (that we does not get bob story)
    assert_equal 1, JSON.parse( response.body ).count
  end

  test "should get new" do
    get new_story_group_url(@story)
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post story_groups_url(@story), params: { group: { desc: @group.desc, groupe_type: @group.groupe_type, name: @group.name } }
    end

    assert_redirected_to story_group_url(@story, Group.last)
  end

  test "should not create bob group" do
    assert_raise do
      post story_plots_url(@bobstory), params: { plot: { desc: @group.desc, name: @group.name } }
    end
  end

  test "should show group" do
    get story_group_url(@story, @group)
    assert_response :success
  end

  test "should not show bob group" do
    assert_raise do
      get story_plots_url(@bobstory, @bobgroup)
      get story_plots_url(@story, @bobgroup)
      get story_plots_url(@bobstory, @group)
    end
  end

  test "should get edit" do
    get edit_story_group_url(@story, @group)
    assert_response :success
  end

  test "should update group" do
    patch story_group_url(@story, @group), params: { group: { desc: @group.desc, groupe_type: @group.groupe_type, name: @group.name } }
    assert_redirected_to story_group_url(@story, @group)
  end

  test "should not allow to steal bob characters" do
    bad_characters = @goodcharacters
    bad_characters[@c3.id] = 'true'
    assert_raise do
      patch story_group_url(@story, @group), params: { character_id: @goodcharacters, group: { desc: @group.desc, name: @group.name } }
    end
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete story_group_url(@story, @group)
    end

    assert_redirected_to story_groups_url(@story)
  end

  test "should not destroy bob plot" do
    assert_raise do
      delete story_plots_url(@bobstory, @bobgroup)
      delete story_plots_url(@story, @bobgroup)
      delete story_plots_url(@bobstory, @group)
    end
  end  
end
