class Schedule::CalendarController < ApplicationController
  include Gws::BaseFilter

  def index
    if params[:keyword].present?
      @plans = Schedule::Plan.any_of name: /.*#{params[:keyword]}.*/
    else
      @plans = Schedule::Plan.all
    end
  end
end
