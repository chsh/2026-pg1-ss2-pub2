class Clock

  def loop_time(interval = 10)
    loop do
        puts Time.now
        sleep interval.to_i
    end
  end
end
