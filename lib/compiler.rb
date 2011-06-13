class Compiler

  @@COMPILE_CMD = "gcc -Wall -x c -fsyntax-only - 2>&1"

  NO_ERROR_MSG = "No syntax error detected!"

  def self.get_syntax_message(src_code)
    return "Syntax error" if src_code.empty?

    msg = IO.popen(@@COMPILE_CMD, 'w+') do |io|
      io.write src_code
      io.close_write
      io.read
    end

    if $? == 0
      return Compiler::NO_ERROR_MSG 
    else
      return msg
    end
  end

  def self.syntax_error?(src_code)
    Compiler.get_syntax_message(src_code) != Compiler::NO_ERROR_MSG 
  end
end
