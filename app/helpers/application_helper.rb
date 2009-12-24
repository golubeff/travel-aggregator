# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def places_title(value)
    return "" if value == "" || value.nil?

    return "нет мест" if value == "N"
    return "места есть" if value == 'Y'
    return 'R'
  end
end
