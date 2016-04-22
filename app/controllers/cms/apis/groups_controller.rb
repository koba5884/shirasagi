class Cms::Apis::GroupsController < ApplicationController
  include Cms::ApiFilter

  model Cms::Group

  def index
    @single = params[:single].present?
    @multi = !@single
    @items = @model.site(@cur_site).
      active.
      search(params[:s]).
      page(params[:page]).per(50)
  end
end
