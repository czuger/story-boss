require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in create(:user)
    @character = create( :character )
    @story = create( :story )
  end

  test "should get index" do
    get story_characters_url( @story )
    assert_response :success
  end

  test "should get new" do
    get new_story_character_url( @story )
    assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      post story_characters_url( @story ), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
    end

    assert_redirected_to story_character_url(@story, Character.last)
  end

  test "should show character" do
    get story_character_url(@story, @character)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_character_url(@story, @character)
    assert_response :success
  end

  test "should update character" do
    patch story_character_url(@story, @character), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
    assert_redirected_to story_character_url(@story, @character)
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete story_character_url(@story, @character)
    end

    assert_redirected_to story_characters_url( @story )
  end
end
