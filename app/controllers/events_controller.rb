class EventsController < ApplicationController
  before_action :logged_in?, except: %i[show index]

  def index
    @events = Event.all
  end

  def new
    if current_user.nil?
      redirect_to '/login'
    else
      @event = current_user.events.build
    end
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
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
