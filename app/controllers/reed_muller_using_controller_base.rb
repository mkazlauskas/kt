class ReedMullerUsingControllerBase < ApplicationController
 
  before_filter :find_reed_muller

  protected

    def find_reed_muller
      @reed_muller = ReedMuller.find_by_id(params[:reed_muller_id])
      redirect_to root_path if @reed_muller.nil?
    end
end