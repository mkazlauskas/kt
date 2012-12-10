class ChannelsController < ApplicationController

  before_filter :find_reed_muller

  def new
    @channel = @reed_muller.build_channel
  end

  def create
    @channel = @reed_muller.build_channel(params[:channel])
    if @channel.save
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