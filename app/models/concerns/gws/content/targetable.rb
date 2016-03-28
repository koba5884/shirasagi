module Gws::Content::Targetable
  extend ActiveSupport::Concern
  extend SS::Translation

  included do
    field :target, type: String, default: "all"

    permit_params :target

    scope :target_to, ->(user) {
      where("$or" => [
        { target: "all" },
        { target: "group", :group_ids.in => user.group_ids }
      ])
    }
  end

  def targetable?
    true
  end

  def target_options
    [
      [I18n.t('gws.options.target.all'), 'all'],
      [I18n.t('gws.options.target.group'), 'group'],
    ]
  end
end
