require 'spec_helper'

describe ClientRoutesController do
  describe "GET show" do
    context "with no escaped fragment parameter" do
      it "should redirect to root with path as goto parameter" do
        get :show, :path => "awesome/cheese"
        expect(response).to redirect_to("/?goto=awesome/cheese")
      end
    end

    context "with escaped fragment parameter" do
      it "should redirect to root with path as goto parameter" do
        get :show, :path => "fake_snapshot", :_escaped_fragment_ => ""
        expect(response).to render_template(:file => "#{Rails.root}/spec/fixtures/fake_snapshot.html")
      end
    end
  end
end
