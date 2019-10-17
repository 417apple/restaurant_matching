module RestaurantsHelper

  def timechange(time)
    timebase = time.strftime("%H:%M")
    return timebase
  end

end
