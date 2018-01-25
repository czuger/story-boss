require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user

    @story = create( :story, user: user )
    @character = create( :character, story: @story )

    # Rubbish to be sure that we are not messing with other users
    bob = create(:user)
    @bobstory = create( :story, user: bob )
    @bobcharacter = create(:character, story: @bobstory )
  end

  test "should get index" do
    get story_characters_url( @story )
    assert_response :success

    get story_characters_url( @story, format: :json )
    # Ensuring that we get only one story (that we does not get bob story)
    assert_equal 1, JSON.parse( response.body ).count
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

  test "should not create for bob" do
    assert_raise do
      post story_characters_url(@bobstory), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
    end
  end

  test "should show character" do
    get story_character_url(@story, @character)
    assert_response :success
  end

  test "should not show bob's characters" do
    assert_raise do
      get story_character_url(@bobstory, @bobcharacter)
      get story_character_url(@story, @bobcharacter)
      get story_character_url(@bobcharacter, @place)
    end
  end

  test "should get edit" do
    get edit_story_character_url(@story, @character)
    assert_response :success
  end


  test "should not edit bob's characters" do
    assert_raise do
      get edit_story_character_url(@bobstory, @bobcharacter)
      get edit_story_character_url(@story, @bobcharacter)
      get edit_story_character_url(@bobcharacter, @place)
    end
  end

  test "should update character" do
    patch story_character_url(@story, @character), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
    assert_redirected_to story_character_url(@story, @character)
  end

  test "should not update bob's characters" do
    assert_raise do
      patch story_character_url(@bobstory, @bobcharacter), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
      patch story_character_url(@story, @bobcharacter), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
      patch story_character_url(@bobcharacter, @place), params: { character: { birth: @character.birth, character: @character.character, death: @character.death, desc: @character.desc, name: @character.name } }
    end
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete story_character_url(@story, @character)
    end

    assert_redirected_to story_characters_url( @story )
  end

  test "should not destroy bob's characters" do
    assert_raise do
      delete story_character_url(@bobstory, @bobcharacter)
      delete story_character_url(@story, @bobcharacter)
      delete story_character_url(@bobcharacter, @place)
    end
  end
end
