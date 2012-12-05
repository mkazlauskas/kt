class ReedMullersController < ApplicationController

  def create
    @reed_muller = ReedMuller.new(params[:reed_muller])
    if @reed_muller.save
      redirect_to @reed_muller
    else
      render 'new'
    end
  end

  def new
    @reed_muller = ReedMuller.new
  end

  def show

  end
end
