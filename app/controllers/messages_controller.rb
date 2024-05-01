class MessagesController < ApplicationController
  def index
    @msg = Message.all
    @new_message = Message.new
  end

  def create
    @new_message = Message.new message_params
    if @new_message.save
      redirect_to messages_path
    else
      render :root_path
    end
  end

  def destroy
    # Message.find_by(id:params[:id]).destroy
    Message.find(params[:id]).destroy

    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
