require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @group = create( :group, story: @story )
  end

  test "should get index" do
    get story_groups_url(@story)
    assert_response :success
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

  test "should show group" do
    get story_group_url(@story, @group)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_group_url(@story, @group)
    assert_response :success
  end

  test "should update group" do
    patch story_group_url(@story, @group), params: { group: { desc: @group.desc, groupe_type: @group.groupe_type, name: @group.name } }
    assert_redirected_to story_group_url(@story, @group)
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete story_group_url(@story, @group)
    end

    assert_redirected_to story_groups_url(@story)
  end
end
