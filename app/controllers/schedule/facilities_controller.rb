class Schedule::FacilitiesController < ApplicationController
  include Gws::BaseFilter
  include SS::CrudFilter
  model Schedule::Facility
end
