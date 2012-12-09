require 'spec_helper'

describe BinaryVectorsController do

  describe '#new' do

    describe "with valid id" do

      let(:rm) { FactoryGirl.create(:reed_muller) }
      before { get :new, reed_muller_id: rm.id }
      
      it { response.should be_success }
      it { assigns(:reed_muller_id).should_not be_nil }
      it { assigns(:vector).should_not be_nil }
    end

    describe "with invalid id" do

      before { get :new, reed_muller_id: 777 }
      it { response.should redirect_to root_path }
    end
  end
end