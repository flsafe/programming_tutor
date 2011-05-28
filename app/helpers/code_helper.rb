module CodeHelper

  # Return transform seconds to a MM:SS format string.
  # Minutes:Seconds
  def to_mm_ss(seconds)
    minutes = seconds / 60
    seconds = seconds % 60

    "#{0 if minutes < 10}#{minutes}:#{0 if seconds < 10}#{seconds}"
  end

  # Messages from the Compiler object or the Feedback object
  # aren't really html aware. This function cleans up the string
  # a little so that it displays as html.
  def to_html_msg(str)
    str.gsub!("<stdin>:", "") # Output from the compiler
    str.gsub!("<", "&lt;")
    str.gsub!(">", "&gt;")
    str.gsub!(/[\n|\r\n]/, '<br\>') # Replace newlines with line breaks 
    str
  end
end
