require 'spec_helper'

describe CoursesController do

  def valid_attributes
    Factory.build(:course).attributes
  end

  before(:each) do
    controller.stub(:current_user).and_return(stub_model(User, :admin? => false))
  end

  describe "GET index" do
    it "assigns all courses as @courses" do
      course = Course.create! valid_attributes
      get :index
      assigns(:courses).should eq([course])
    end
  end

  describe "GET show" do
    it "assigns the requested course as @course" do
      course = Course.create! valid_attributes
      get :show, :id => course.id.to_s
      assigns(:course).should eq(course)
    end
  end

  context "The user is not an admin" do
    it_behaves_like "admin resource controller"
  end

  context "The user is an admin" do
    before(:each) do
      controller.stub(:current_user).and_return(stub_model(User, :admin? => true))
    end

    describe "GET new" do
      it "assigns a new course as @course" do
        get :new
        assigns(:course).should be_a_new(Course)
      end
    end

    describe "GET edit" do
      it "assigns the requested course as @course" do
        course = Course.create! valid_attributes
        get :edit, :id => course.id.to_s
        assigns(:course).should eq(course)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Course" do
          expect {
            post :create, :course => valid_attributes
          }.to change(Course, :count).by(1)
        end

        it "assigns a newly created course as @course" do
          post :create, :course => valid_attributes
          assigns(:course).should be_a(Course)
          assigns(:course).should be_persisted
        end

        it "redirects to the created course" do
          post :create, :course => valid_attributes
          response.should redirect_to(Course.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved course as @course" do
          # Trigger the behavior that occurs when invalid params are submitted
          Course.any_instance.stub(:save).and_return(false)
          post :create, :course => {}
          assigns(:course).should be_a_new(Course)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Course.any_instance.stub(:save).and_return(false)
          post :create, :course => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested course" do
          course = Course.create! valid_attributes
          # Assuming there are no other courses in the database, this
          # specifies that the Course created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Course.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => course.id, :course => {'these' => 'params'}
        end

        it "assigns the requested course as @course" do
          course = Course.create! valid_attributes
          put :update, :id => course.id, :course => valid_attributes
          assigns(:course).should eq(course)
        end

        it "redirects to the course" do
          course = Course.create! valid_attributes
          put :update, :id => course.id, :course => valid_attributes
          response.should redirect_to(course)
        end
      end

      describe "with invalid params" do
        it "assigns the course as @course" do
          course = Course.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Course.any_instance.stub(:save).and_return(false)
          put :update, :id => course.id.to_s, :course => {}
          assigns(:course).should eq(course)
        end

        it "re-renders the 'edit' template" do
          course = Course.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Course.any_instance.stub(:save).and_return(false)
          put :update, :id => course.id.to_s, :course => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested course" do
        course = Course.create! valid_attributes
        expect {
          delete :destroy, :id => course.id.to_s
        }.to change(Course, :count).by(-1)
      end

      it "redirects to the courses list" do
        course = Course.create! valid_attributes
        delete :destroy, :id => course.id.to_s
        response.should redirect_to(courses_url)
      end
    end
  end
end
