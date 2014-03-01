Time::DATE_FORMATS[:upcoming_date] = ->(time) do
  if time - Time.now > 7.days
    time.strftime("%b %d, at %l:%M%p")
  else
    include ActionView::Helpers::DateHelper 
    time.strftime("This %a at %l:%M%p")
  end
end

