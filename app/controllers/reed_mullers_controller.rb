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
  
  def show
    @reed_muller = ReedMuller.find_by_id(params[:id])
    return redirect_to root_path if @reed_muller.nil?
    if params[:binary_vector].nil?
      @received_vector = @reed_muller.channel.send_vector(@reed_muller.encoded_vector)
    else
      params[:binary_vector][:size] = @reed_muller.encoded_vector.count
      @received_vector = BinaryVector.create(params[:binary_vector])
    end
    if @received_vector.errors.count == 0
      errors = Channel.diff(@reed_muller.encoded_vector.elements, @received_vector.elements)
      @error_indexes = errors.map { |i| i.to_s }.join(', ')
      if errors.count > (0.5*((2**(@reed_muller.m-@reed_muller.r))-1))
        flash.now[:error] = "Too many errors for this code"
      end
      @decoded_vector = @reed_muller.decode_vector(@received_vector)
    end
  end
end