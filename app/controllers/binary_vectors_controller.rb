class BinaryVectorsController < ApplicationController

  before_filter :find_reed_muller

  def new
    @vector = @reed_muller.build_binary_vector(
      size: @reed_muller.code_length)
  end

  def create
    @vector = @reed_muller.build_binary_vector(params[:binary_vector])
    if @vector.save
      redirect_to @reed_muller
    else
      render "new"
    end
  end

  private

    def find_reed_muller
      @reed_muller = ReedMuller.find_by_id(params[:reed_muller_id])
      redirect_to root_path if @reed_muller.nil?
    end
end