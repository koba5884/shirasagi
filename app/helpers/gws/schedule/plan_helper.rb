module Gws::Schedule::PlanHelper
  def term(item)
    if item.allday?
      dates = [item.start_at.to_date, item.end_at.to_date].uniq
      dates.map! { |m| I18n.l(m, format: :gws_long) }
    else
      dates = [item.start_at, item.end_at].uniq
      if dates.size == 1
        dates.map! { |m| I18n.l(m, format: :gws_long) }
      elsif dates[0].to_date == dates[1].to_date
        dates = [I18n.l(item.start_at, format: :gws_long), I18n.l(item.end_at, format: :gws_time)]
      else
        dates.map! { |m| I18n.l(m, format: :gws_long) }
      end
    end
    dates.join(" - ")
  end

  def calendar_format(plans, opts = {})
    events  = plans.map { |m| m.calendar_format(@cur_user, @cur_site) }
    events += calendar_holidays opts[:holiday][0], opts[:holiday][1] if opts[:holiday]
    events += group_holidays opts[:holiday][0], opts[:holiday][1] if opts[:holiday]
    events
  end

  def group_holidays(start_at, end_at)
    Gws::Schedule::Holiday.site(@cur_site).and_public.
      search(start_at: start_at, end_at: end_at).
      map(&:calendar_format)
  end

  def calendar_holidays(start_at, end_at)
    HolidayJapan.between(start_at, end_at).map do |date, name|
      { className: 'fc-holiday', title: "  #{name}", start: date, allDay: true, editable: false }
    end
  end
end
