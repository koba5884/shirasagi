class Schedule::PlansController < ApplicationController
  include Gws::BaseFilter
  include SS::CrudFilter

  model Schedule::Plan

  def create
    respond_to do |format|
      format.html { super }
      format.json { super }
      format.js do
        @item = @model.new get_params
        if @item.save
          render status: 200
        else
          render status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.html { super }
      format.json { super }
      format.js do
        if @item.update ajax_params
          render status: 200
        else
          render status: 403
        end
      end
    end
  end

  private
    def pre_params
      now = Time.zone.now
      min = now.min / 5 * 5
      start_at = Time.zone.local now.year, now.month, now.day, now.hour, min
      {start_at: start_at, end_at: start_at + 5.minutes}
    end

    def ajax_params
      if params[:end_at] == ''
        span = self.end_at - self.start_at
        start_at = params[:start_at]
        end_at = start_at + span
      else
        start_at = params[:start_at]
        end_at = params[:end_at]
      end
      {start_at: start_at, end_at: end_at}
    end
end
