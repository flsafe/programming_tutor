require 'spec_helper'

describe Code do
  describe "#get_syntax_message" do
    def ok_code
      code =<<-END
      void remove_from_str(char remove_chars[], char str[]){
        int  read = 0, write = 0, i = 0;
        char removetab[128] = {'\\0'}, c = 0;
        char useless_test = "just testing special characters\\n";

        if( ! (remove_chars && str) )
          return;

        for(i = 0 ; remove_chars[i] ; i++){
          removetab[ remove_chars[i] ] = 1;
        }

        do{
          c = str[read];
          if( ! removetab[c] ){
            str[write++] = str[read];
          }
          read++;
        }while(c);
      }
      END
    end

    def syntax_error 
      code =<<-END
      void remove_from_str(char remove_chars[], char str[]){
        int  read = 0, write = 0, i = 0;
        char removetab[128] = {'\\0'}, c = 0;

        if( ! (remove_chars && str) )
          return;

        for(i = 0  remove_chars[i] ; i++){ /* missing semi colon */
          removetab[ remove_chars[i] ] = 1;
        }

        do{
          c = str[read];
          if( ! removetab[c] ){
            str[write++] = str[read];
          }
          read++;
        }while(c);
      }
      END
    end

    context "syntax error" do
      it "returns a syntax error description" do
        code = Code.new(:src_code=>syntax_error) 
        code.get_syntax_message.should =~ /syntax error/i
      end
    end

    context "no syntax error" do
      it "returns a 'no syntax error' message" do
        code = Code.new(:src_code=>ok_code)
        code.get_syntax_message.should =~ /no syntax error detected/i
      end
    end
  end
end
