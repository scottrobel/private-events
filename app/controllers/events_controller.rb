class EventsController < ApplicationController
  before_action :require_login, only:[:new]
  def new
    @event = Event.new
  end
end
