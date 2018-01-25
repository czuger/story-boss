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

    if @current_story && @current_story.user != current_user
      raise "Trying to read a story that is not owned by user : #{@current_story.user.email}, #{current_user.email}"
    end
  end

end
