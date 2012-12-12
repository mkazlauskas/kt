class BinaryVectorsController < ReedMullerUsingControllerBase

  def new
    @vector = @reed_muller.build_binary_vector(
      size: @reed_muller.code_length)
  end

  def create
    @vector = @reed_muller.build_binary_vector(params[:binary_vector])
    if @vector.save
      redirect_to new_channel_path(reed_muller_id: @reed_muller.id)
    else
      render "new"
    end
  end

end