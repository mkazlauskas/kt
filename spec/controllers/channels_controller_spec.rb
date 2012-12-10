require 'spec_helper'

describe ChannelsController do

  let(:rm) { FactoryGirl.create(:reed_muller, channel: nil) }

  describe '#new' do

    before { get :new, reed_muller_id: rm.id }
    it { response.should be_success }
    it { assigns(:channel).should_not be_nil }
    it { assigns(:reed_muller).should_not be_nil }
  end

  describe '#create' do
    
    describe 'valid' do
      
      let(:channel) { { reliability: 80 } }
      before { post :create, channel: channel, reed_muller_id: rm.id }
      it { response.should redirect_to(reed_muller_path(id: rm.id)) }
    end

    describe 'invalid' do
      
      let(:channel) { { reliability: 101 } }
      before { post :create, channel: channel, reed_muller_id: rm.id }
      it { response.should render_template 'new' }
    end
  end
end