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

  describe "check against" do
    before(:each) do
      Feedback.stub(:on).and_return("Nice!")
      @src_code = "int main(){return 0;}"
      @unit_test = mock_model(UnitTest).as_null_object
      @code = Code.new(:src_code=>@src_code)
    end

    it "runs the unit test on the filled in solution template src code" do
      @unit_test.should_receive(:execute).with(@src_code)
      @code.check_against(@unit_test)
    end

    it "gets feedback on the resulting unit test gradesheet" do
      Feedback.should_receive(:on)
      @code.check_against(@unit_test).should == "Nice!"
    end
  end
end
