# Teksto zinutes kontroleris.
# Kontroliuoja naujos zinutes kurima.

class StringMessagesController < ReedMullerUsingControllerBase

  def new
    @string_message = @reed_muller.build_string_message
  end

  def create
    @string_message = @reed_muller.build_string_message(params[:string_message])
    if @string_message.save
      redirect_to new_channel_path(reed_muller_id: @reed_muller.id)
    else
      render "new"
    end
  end

end