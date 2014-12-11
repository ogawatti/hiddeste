class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth_hash = request.env['omniauth.auth']

    user = User.find_or_create_with_auth_hash(auth_hash)
    session[:user_id] = user.id

    callback_path = if user.active?
      if session[:callback_path] && session[:callback_path] != "/"
        session[:callback_path]
      else
        "/events"
      end
    else
      "/users/#{user.id}/new"
    end

    session[:callback_path] = nil
    redirect_to callback_path
  end 

  def failure
    redirect_to "/" 
  end 
end
