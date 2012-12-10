require 'spec_helper'

describe BinaryVectorsController do

  describe '#new' do

    describe "with valid id" do

      let(:rm) { FactoryGirl.create(:reed_muller) }
      before { get :new, reed_muller_id: rm.id }
      
      it { response.should be_success }
      it { assigns(:reed_muller).should_not be_nil }
      it { assigns(:vector).should_not be_nil }
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
        let(:vector) { { elements: '1'*rm.code_length.size, size: rm.code_length.size } }
        before { post :create, binary_vector: vector, reed_muller_id: rm.id }
        it { response.should redirect_to(reed_muller_path(id: rm.id)) }
      end

      describe 'with invalid length' do
        let(:vector) { { elements: '1'*(rm.code_length.size+1), size: rm.code_length.size } }
        before { post :create, binary_vector: vector, reed_muller_id: rm.id }
        it { response.should render_template 'new' }
        it { assigns(:vector).errors.count.should_not == 0 }
      end
    end
  end
end