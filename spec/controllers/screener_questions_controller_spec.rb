require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ScreenerQuestionsController do

  # This should return the minimal set of attributes required to create a valid
  # ScreenerQuestion. As you add validations to ScreenerQuestion, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "text" => "MyText" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScreenerQuestionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all screener_questions as @screener_questions" do
      screener_question = ScreenerQuestion.create! valid_attributes
      get :index, {}, valid_session
      assigns(:screener_questions).should eq([screener_question])
    end
  end

  describe "GET show" do
    it "assigns the requested screener_question as @screener_question" do
      screener_question = ScreenerQuestion.create! valid_attributes
      get :show, {:id => screener_question.to_param}, valid_session
      assigns(:screener_question).should eq(screener_question)
    end
  end

  describe "GET new" do
    it "assigns a new screener_question as @screener_question" do
      get :new, {}, valid_session
      assigns(:screener_question).should be_a_new(ScreenerQuestion)
    end
  end

  describe "GET edit" do
    it "assigns the requested screener_question as @screener_question" do
      screener_question = ScreenerQuestion.create! valid_attributes
      get :edit, {:id => screener_question.to_param}, valid_session
      assigns(:screener_question).should eq(screener_question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ScreenerQuestion" do
        expect {
          post :create, {:screener_question => valid_attributes}, valid_session
        }.to change(ScreenerQuestion, :count).by(1)
      end

      it "assigns a newly created screener_question as @screener_question" do
        post :create, {:screener_question => valid_attributes}, valid_session
        assigns(:screener_question).should be_a(ScreenerQuestion)
        assigns(:screener_question).should be_persisted
      end

      it "redirects to the created screener_question" do
        post :create, {:screener_question => valid_attributes}, valid_session
        response.should redirect_to(ScreenerQuestion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved screener_question as @screener_question" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScreenerQuestion.any_instance.stub(:save).and_return(false)
        post :create, {:screener_question => { "text" => "invalid value" }}, valid_session
        assigns(:screener_question).should be_a_new(ScreenerQuestion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ScreenerQuestion.any_instance.stub(:save).and_return(false)
        post :create, {:screener_question => { "text" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested screener_question" do
        screener_question = ScreenerQuestion.create! valid_attributes
        # Assuming there are no other screener_questions in the database, this
        # specifies that the ScreenerQuestion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ScreenerQuestion.any_instance.should_receive(:update).with({ "text" => "MyText" })
        put :update, {:id => screener_question.to_param, :screener_question => { "text" => "MyText" }}, valid_session
      end

      it "assigns the requested screener_question as @screener_question" do
        screener_question = ScreenerQuestion.create! valid_attributes
        put :update, {:id => screener_question.to_param, :screener_question => valid_attributes}, valid_session
        assigns(:screener_question).should eq(screener_question)
      end

      it "redirects to the screener_question" do
        screener_question = ScreenerQuestion.create! valid_attributes
        put :update, {:id => screener_question.to_param, :screener_question => valid_attributes}, valid_session
        response.should redirect_to(screener_question)
      end
    end

    describe "with invalid params" do
      it "assigns the screener_question as @screener_question" do
        screener_question = ScreenerQuestion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScreenerQuestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => screener_question.to_param, :screener_question => { "text" => "invalid value" }}, valid_session
        assigns(:screener_question).should eq(screener_question)
      end

      it "re-renders the 'edit' template" do
        screener_question = ScreenerQuestion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ScreenerQuestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => screener_question.to_param, :screener_question => { "text" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested screener_question" do
      screener_question = ScreenerQuestion.create! valid_attributes
      expect {
        delete :destroy, {:id => screener_question.to_param}, valid_session
      }.to change(ScreenerQuestion, :count).by(-1)
    end

    it "redirects to the screener_questions list" do
      screener_question = ScreenerQuestion.create! valid_attributes
      delete :destroy, {:id => screener_question.to_param}, valid_session
      response.should redirect_to(screener_questions_url)
    end
  end

end
