FactoryGirl.define do
  factory :schedule_category, class: Schedule::Category do
    name 'category-#{unique_id}'
  end
end
