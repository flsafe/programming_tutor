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
end

