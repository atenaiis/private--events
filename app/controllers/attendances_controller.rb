class AttendancesController < ApplicationController
    def new
        @attendance = current_user.attendance.build
      end
    
      def create
        @attendance = current_user.attendance.build
        @attendance.attended_event_id = params[:event_id]
        @attendance.save
        redirect_to '/events'
      end

  def invite
    invitee = User.find_by(username: params[:username])
    UserEvent.create(attendee_id: invitee.id, attended_event_id: params[:event_id]) unless invitee.nil?
    redirect_to "/events/#{params[:event_id]}"
  end
    end 

