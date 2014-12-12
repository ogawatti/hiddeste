class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :create_og_tag
  helper_method :current_user, :logged_in?

  def current_user
    @user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user && current_user.active?
  end

  def user_authentication
    redirect_to "/" unless logged_in?
  end

  private

  def create_og_tag
    @og = Hashie::Mash.new
    Settings.og.each_key do |tag|
      @og.send(tag + "=", Settings.og.send(tag)) unless tag == "article"
    end
    @og.article_author = Settings.og.article.author
    @og.facebook_app_id = Settings.facebook.app.id
  end
end
