require 'spec_helper'

describe ReedMullersController do

  describe '#new' do

    before { get :new }
    it { response.should be_success }
    it { assigns(:reed_muller).should_not be_nil }
  end

  describe '#create' do

    describe "valid parameters" do

      let(:rm) { { id: 1, r: 3, m: 5 } }
      it "should redirect to new reed muller path" do
        post :create, reed_muller: rm
        response.should redirect_to new_binary_vector_path(
          reed_muller_id: rm[:id])
      end

      it "should persist reed muller" do
        expect { post :create, reed_muller: rm }.
          to change { ReedMuller.count }.by(1)
      end
    end

    describe "invalid parameters" do

      let(:rm) { { id: 1, r: 5, m: 3 } }
      it "should render error" do
        post :create, reed_muller: rm
        response.should render_template "new"
        assigns(:reed_muller).errors.count.should_not == 0
      end

      it "should not persist reed muller" do
        expect { post :create, reed_muller: rm }.
          to change { ReedMuller.count }.by(0)
      end
    end
  end
end