module CodeHelper
  def to_mm_ss(seconds)
    minutes = seconds / 60
    seconds = seconds % 60

    "#{0 if minutes < 10}#{minutes}:#{0 if seconds < 10}#{seconds}"
  end
end
