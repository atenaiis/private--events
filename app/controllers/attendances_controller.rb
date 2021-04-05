class AttendancesController < ApplicationController
    def new
        @attendance = current_user.attendances.build
      end
    
      def create
        @attendance = current_user.attendances.build
        @attendance.attended_event_id = params[:event_id]
        @attendance.save
        redirect_to '/events'
      end
    end
