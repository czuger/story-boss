class ApplicationController < ActionController::Base
  before_action :set_locale, :authenticate_user!
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_current_story
    @current_story = Story.where( id: params[ :story_id ] || params[ :id ] ).first
    @current_story = @current_story || Story.where( current: true ).first

    # p current_user

    if @current_story && @current_story.user != current_user
      raise "Trying to read a story that is not owned by user : #{@current_story.user.email}, #{current_user.email}"
    end
  end

  private

  def set_linked_characters( model )
    character_ids = params[:character_id]&.to_unsafe_h || []

    to_update_character_ids = character_ids.to_a.map{ |e| e[0].to_i if e[1] == 'true' }.compact
    available_character_ids = @current_story.characters.pluck(:id)

    raise "Trying to link unpermitted characters to_update_character_ids = #{to_update_character_ids}, available_characters_ids = #{available_character_ids}" unless ( to_update_character_ids - available_character_ids ).empty?
    model.character_ids = to_update_character_ids
    model.save
  end

end
