class Schedule::Facility
  include SS::Document
  include Gws::Addon::GroupPermission

  field :name, type: String

  permit_params :name
end
