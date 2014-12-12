class UsersController < ApplicationController
  before_filter :user_authentication, except: [:signin, :index]
  before_filter :validate_user, except: [:signin, :index]

  def signin
    if params["agree"]["user_policy"].to_i == 1
      redirect_to user_omniauth_authorize_path(:facebook)
    else
      redirect_to "/authentication"
    end
  end

  def show
    @events = @user.events
  end

  def new
    if @user.active?
      redirect_to "/404"
    else
      render "edit"
    end
  end

  def edit
  end

  def update
    @user.name   = params["user"]["name"]
    @user.notice = !!params["user"]["notice"]
    @user.active = true
    if @user.save
      request_path = URI.parse(request.env["HTTP_REFERER"]).path
      redirect_path = "/users/#{@user.id}"
      redirect_path += "/edit" if request_path =~ /^\/users\/\d+\/edit$/
      redirect_to redirect_path
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to "/"
  end

  private

  def validate_user
    id = params[:id]
    redirect_to "/" unless session[:user_id].to_s == id
    @user = User.find_by_id(id)
  end

  def user_authentication
    redirect_to "/" unless current_user
  end
end
