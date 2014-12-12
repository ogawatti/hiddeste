class NoticesController < ApplicationController
  before_filter :user_authentication

  def create
    notice = Notice.new
    notice.event_id = params["event_id"]
    event_url = url_for(controller: "events", action: "show", id: notice.event_id)
    user = User.find_by_id(params["user_id"])

    users = notice.event.notice_users
    users = users.where(id: user.id) if user
    unless users.empty?
      notice.save
      users.each{|user| GraphAPI.feed(user.access_token, { link: event_url }) }
    end
    redirect_to "/events/#{notice.event_id}"
  end
end
