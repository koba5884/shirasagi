class Schedule::CategoriesController < ApplicationController
  include Gws::BaseFilter
  include SS::CrudFilter
  model Schedule::Category
end
