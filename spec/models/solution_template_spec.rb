require 'spec_helper'

describe SolutionTemplate do

  describe "#prototype" do
    it "returns the prototype section of the src code" do
      src_code = <<-END
      void test();
      int main(){
        test();
      }
      /*start_prototype*/
      void test(){
        
      }
      /*end_prototype*/
      END
      
      prototype = <<-END
      void test(){
        
      }
      END
      template = SolutionTemplate.new(:src_code=>src_code)
      template.prototype.should == prototype.strip.chomp
   end
  end

   describe "#fill_in" do
    
     it "replaces code between start_prorotype and end_prototype and returns the result" do
     template_code = <<-END
      /*start_prototype*/
      void remove_char(char c, char str[]){
    
        /*Your code goes here*/
    
      }
      /*end_prototype*/
     END
     solution_snippet = <<-END
      void remove_char(){
        char a = '\\0'
        return 0;
      }
     END
      template = SolutionTemplate.new(:src_code=>template_code)
      solution_code = template.fill_in(solution_snippet);
      solution_code == solution_snippet.strip.chomp
    end
  end
end

