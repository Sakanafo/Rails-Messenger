# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    @pagy, @messages = pagy(Message.where(room_id: nil).order(created_at: :desc).includes(:user), items: 5)
    @new_message = Message.new
  end

  def create
    @new_message = Message.new message_params
    @new_message.user = current_user if current_user.present?
    flash[:error] = 'Error sending message' unless @new_message.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    message = Message.find(params[:id])
    if message.user == current_user
      message.destroy
      flash[:notice] = 'Message deleted'
    else
      flash[:error] = 'You cannot delete this message'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id)
  end
end
