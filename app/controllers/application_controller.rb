class ApplicationController < ActionController::Base
  before_action :set_locale, :authenticate_user!, :set_current_story
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_current_story
    @current_story = Story.where( id: params[ :story_id ] || params[ :id ] ).first
    @current_story = @current_story || Story.where( current: true ).first

    # p current_user

    raise unless @current_story.user == current_user
  end

end
