# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @pagy, @messages = pagy(Message.order(created_at: :desc).includes(:user), items: 5)
    @new_message = Message.new
  end

  def create
    @new_message = Message.new message_params
    @new_message.user = current_user if current_user.present?
    @new_message.save ? '' : flash[:error] = 'Error sending message'

    redirect_to messages_path
  end

  def destroy
    Message.find(params[:id]).destroy

    redirect_to messages_path, status: :see_other
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
