class User::EventsController < ApplicationController
  def create
    user_event          = UserEvent.new
    user_event.user_id  = current_user.id
    user_event.event_id = params["event_id"]
    user_event.save
    redirect_to redirect_path
  end

  def destroy
    if user_event = UserEvent.find_by_id(params[:id])
      user_event.destroy
    end
    redirect_to redirect_path
  end

  private
  
  def redirect_path
    URI.parse(request.env["HTTP_REFERER"]).path || "/events"
  end
end
