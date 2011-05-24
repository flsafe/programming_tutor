class Compiler

  @@COMPILE_CMD = "gcc -Wall -x c -fsyntax-only - 2>&1"

  def self.get_syntax_message(src_code)
    return "Syntax error" if src_code == nil

    msg = IO.popen(@@COMPILE_CMD, 'w+') do |io|
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
end
