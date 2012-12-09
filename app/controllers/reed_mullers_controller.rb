class ReedMullersController < ApplicationController

  def create
    @reed_muller = ReedMuller.new(params[:reed_muller])
    if @reed_muller.save
      redirect_to new_binary_vector_path(reed_muller_id: @reed_muller.id)
    else
      render "new"
    end
  end

  def new
    @reed_muller = ReedMuller.new
  end
  
end
