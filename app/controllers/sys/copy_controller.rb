class Sys::CopyController < ApplicationController
  include Sys::BaseFilter

  #app/controllers/concerns/sys 以下にて記述
  include Sys::SiteCopyValid

  private
    def set_crumbs
      @crumbs << [:"sys.copy", sys_copy_path]
    end

  public
    def index
      @copy  = Sys::Copy.new
      @items = []
      render :action => 'index'
    end

    def confirm
      chk_valid
    end

    def run
      Sys::CopyJob.call_async(params)
      SS::RakeRunner.run_async "job:run", "RAILS_ENV=#{Rails.env}"
    end
end