require 'spec_helper'

describe "lessons/index.html.erb" do
  before(:each) do
    assign(:lessons, [
      stub_model(Lesson,
        :title => "Title",
        :description => "MyText",
        :text => "MyText"
      ),
      stub_model(Lesson,
        :title => "Title",
        :description => "MyText",
        :text => "MyText"
      )
    ])
    view.stub(:current_user).and_return(stub_model(User, :anonymous=>true, :admin? => false))
  end

  context "when the user is not an admin" do
    it "renders a list of lessons" do
      render
      rendered.should have_selector("li.lesson_list_item")
    end

    it "does not show the admin links (edit, destroy or 'new lesson' link)" do
      render
      rendered.should_not have_selector("#lessons_list li a.small_content_link")
    end
  end

  context "when the user is an admin" do
    it "shows the admin links (edit, destroy, 'new lesson')" do
      view.stub(:current_user).and_return stub_model(User, :admin? => true)
      render
      rendered.should have_selector("#lessons_list li a.small_content_link")
    end
  end
end
