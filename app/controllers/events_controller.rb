class EventsController < ApplicationController
  helper_method :organizer?
  before_filter :new_event,  only: [:new, :create]
  before_filter :find_event, only: [:show, :update, :destroy]

  def index
    @events = Event.all.reverse
  end

  def show
    if @event.nil?
      redirect_to "/404"
    else
      update_og_tag
    end
  end

  def new
  end

  def create
    if save_event(params["event"])
      redirect_to "/events/#{@event.id}"
    else
      render 'new'
    end
  end

  def update
    if @event.nil?
      redirect_to "/404"
    else
      if save_event(params["event"])
        redirect_to "/events/#{@event.id}"
      else
        render 'show'
      end
    end
  end

  def destroy
    if @event.nil?
      redirect_to "/404"
    else
      @event.destroy
      redirect_to "/events"
    end
  end

  private

  def new_event
    @event = Event.new
    @event.organizer_id = current_user.id
  end

  def find_event
    @event = Event.find_by_id(params[:id])
  end

  def save_event(options={})
    options.each do |k, v|
      method_name = "#{k}="
      @event.send(method_name, v) if @event.respond_to?(method_name)
    end
    @event.save
  end

  def organizer?(user=nil)
    if user.blank?
      !!(logged_in? && @event.organizer == current_user)
    else
      !!(@event.organizer == user)
    end
  end

  def update_og_tag
    @og.url            = request.url
    @og.title          = @event.name
    @og.description    = @event.og_description
    @og.article_author = @event.organizer.link
  end
end
