# Tableless model representing the code
# the user types into the text editor when
# solving an exercise.
class Code < ActiveRecord::Base

  COMPILE_CMD = "gcc -Wall -x c -fsyntax-only - 2>&1"

  def get_syntax_message
    return "Syntax error" if src_code == nil

    msg = IO.popen(COMPILE_CMD, 'w+') do |io|
      io.write src_code
      io.close_write
      io.read
    end

    if $? == 0
      return "No syntax error detected!"
    else
      return msg
    end
  end

  # Tableless model
  def self.columns() @columns ||= []; end  
   
  def self.column(name, sql_type = nil, default = nil, null = true)  
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
  end  

  column :src_code, :text    
end
