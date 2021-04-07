class EventsController < ApplicationController
  before_action :logged_in?, except: %i[show index]

  def index
    @events = Event.all
    @past_events = Event.previous
    @upcoming_events = Event.upcoming
  end

  def new
    if current_user.nil?
      redirect_to '/login'
    else
      @event = current_user.events.build
    end
  end

  def create
  @event = current_user.events.build(event_params)
  @event.save
  redirect_to "/events/#{@event.id}"
end

  def invite
    invitee = User.find_by(name: params[:name])
    UserEvent.create(attendee_id: invitee.id, attended_event_id: params[:event_id]) unless invitee.nil?
    redirect_to "/events/#{params[:event_id]}"
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :local, :description)
  end
end
