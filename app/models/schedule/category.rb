class Schedule::Category
  include SS::Document
  include Gws::Addon::GroupPermission

  field :name, type: String
  field :color, type: String

  permit_params :name, :color

  has_many :plans, class_name: 'Schedule::Plan', dependent: :destroy

  validates :name, uniqueness: true
end
