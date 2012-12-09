class BinaryVectorsController < ApplicationController

  def new
    reed_muller = ReedMuller.find_by_id(params[:reed_muller_id])
    return redirect_to root_path if reed_muller.nil?
    @vector = reed_muller.new_message
    @reed_muller_id = reed_muller.id
  end
end
