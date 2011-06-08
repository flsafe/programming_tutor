require 'spec_helper'

describe ExercisesController do

  def valid_attributes
    {:title=>'title', 
     :minutes=>1,
     :unit_test_attributes=>{:src_code=>'code', :src_language=>"lang"},
     :solution_template_attributes=>{:src_code=>'code', :src_language=>'lang'}}
  end
  
  context "when the user is not an admin" do

    it_behaves_like "admin resource controller"

    describe "GET index" do
      before(:each) do
        controller.stub(:current_user).and_return(stub_model(User, :admin? => false))
      end

      it "redirects when the index is requested" do
        get :index
        response.should redirect_to(home_path)
      end

      it "redirects when the show is requested" do
        e = Exercise.create!(valid_attributes)
        get :show, :id=>e.id.to_s 
        response.should redirect_to(home_path)
      end
    end
  end

  context "when user is an admin" do
    before(:each) do
      controller.stub(:current_user).and_return(stub_model(User, :admin? => true))
    end

    describe "GET index" do
      it "assigns all exercises as @exercises" do
        exercise = Exercise.create! valid_attributes
        get :index
        assigns(:exercises).should eq([exercise])
      end
    end

    describe "GET show" do
      it "assigns the requested exercise as @exercise" do
        exercise = Exercise.create! valid_attributes
        get :show, :id => exercise.id.to_s
        assigns(:exercise).should eq(exercise)
      end
    end

    describe "GET new" do
      it "assigns a new exercise as @exercise" do
        get :new
        assigns(:exercise).should be_a_new(Exercise)
      end
    end

    describe "GET edit" do
      it "assigns the requested exercise as @exercise" do
        exercise = Exercise.create! valid_attributes
        get :edit, :id => exercise.id.to_s
        assigns(:exercise).should eq(exercise)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Exercise" do
          expect {
            post :create, :exercise => valid_attributes
          }.to change(Exercise, :count).by(1)
        end

        it "assigns a newly created exercise as @exercise" do
          post :create, :exercise => valid_attributes
          assigns(:exercise).should be_a(Exercise)
          assigns(:exercise).should be_persisted
        end

        it "redirects to the created exercise" do
          post :create, :exercise => valid_attributes
          response.should redirect_to(Exercise.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved exercise as @exercise" do
          # Trigger the behavior that occurs when invalid params are submitted
          Exercise.any_instance.stub(:save).and_return(false)
          post :create, :exercise => {}
          assigns(:exercise).should be_a_new(Exercise)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Exercise.any_instance.stub(:save).and_return(false)
          post :create, :exercise => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested exercise" do
          exercise = Exercise.create! valid_attributes
          # Assuming there are no other exercises in the database, this
          # specifies that the Exercise created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Exercise.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => exercise.id, :exercise => {'these' => 'params'}
        end

        it "assigns the requested exercise as @exercise" do
          exercise = Exercise.create! valid_attributes
          put :update, :id => exercise.id, :exercise => valid_attributes
          assigns(:exercise).should eq(exercise)
        end

        it "redirects to the exercise" do
          exercise = Exercise.create! valid_attributes
          put :update, :id => exercise.id, :exercise => valid_attributes
          response.should redirect_to(exercise)
        end
      end

      describe "with invalid params" do
        it "assigns the exercise as @exercise" do
          exercise = Exercise.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Exercise.any_instance.stub(:save).and_return(false)
          put :update, :id => exercise.id.to_s, :exercise => {}
          assigns(:exercise).should eq(exercise)
        end

        it "re-renders the 'edit' template" do
          exercise = Exercise.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Exercise.any_instance.stub(:save).and_return(false)
          put :update, :id => exercise.id.to_s, :exercise => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested exercise" do
        exercise = Exercise.create! valid_attributes
        expect {
          delete :destroy, :id => exercise.id.to_s
        }.to change(Exercise, :count).by(-1)
      end

      it "redirects to the exercises list" do
        exercise = Exercise.create! valid_attributes
        delete :destroy, :id => exercise.id.to_s
        response.should redirect_to(exercises_url)
      end
    end
  end
end
