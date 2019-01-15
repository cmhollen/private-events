class EventsController < ApplicationController

    def index
        @events = Event.all 
        @upcoming = @events.upcoming_events
        @past = @events.past_events
    end

    def new
        @event = Event.new
    end

    def create
        @event = current_user.created_events.build(event_params)
        if @event.save
            @event.attendees << current_user
            redirect_to current_user
        else 
            render 'new'
        end
    end

    def show
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.attendees << current_user
        redirect_to events_path
        flash[:success] = "You've joined the event!"
    end

    private

    def event_params
        params.require(:event).permit(:description, :date)
    end
end
