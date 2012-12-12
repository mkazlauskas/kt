require 'spec_helper'

describe StringMessagesController do

  describe '#new' do

    describe "with valid id" do

      let(:rm) { FactoryGirl.create(:reed_muller) }
      before { get :new, reed_muller_id: rm.id }
      
      it { response.should be_success }
      it { assigns(:reed_muller).should_not be_nil }
      it { assigns(:string_message).should_not be_nil }
    end

    describe "with invalid id" do

      before { get :new, reed_muller_id: 777 }
      it { response.should redirect_to root_path }
    end
  end

  describe '#create' do
    describe "with valid id" do

      let(:rm) { FactoryGirl.create(:reed_muller) }

      describe 'with valid length' do
        let(:string_message) { { message: 'zdr kary' } }
        before { post :create, string_message: string_message, reed_muller_id: rm.id }
        it { response.should redirect_to(new_channel_path(reed_muller_id: rm.id)) }
      end

      describe 'with invalid length' do
        let(:string_message) { { message: nil } }
        before { post :create, string_message: string_message, reed_muller_id: rm.id }
        it { response.should render_template 'new' }
        it { assigns(:string_message).errors.count.should_not == 0 }
      end
    end
  end
end
