class StaticsController < ApplicationController
  def top
  end

  def terms_of_use
  end

  def privacy_policy
    @contact_email = Settings.contact.email
  end

  def authentication
    redirect_to "/" if logged_in?
    callback_url = request.env["HTTP_REFERER"] || "/"
    session[:callback_path] = URI.parse(callback_url).path
  end

  def signout
    redirect_path = URI.parse(request.env["HTTP_REFERER"]).path
    reset_session
    if redirect_path
      case redirect_path
      when /^\/users/       then redirect_to "/"
      when /^\/events\/new/ then redirect_to "/"
      else                       redirect_to redirect_path
      end
    else
      redirect_to "/"
    end
  end
end
