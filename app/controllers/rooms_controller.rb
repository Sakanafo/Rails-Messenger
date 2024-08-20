class RoomsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    p params
    @rooms = Room.all
    @rooms = RoomSearchService.new(params[:query]).search if params[:query].present?
    @pagy, @rooms = pagy(@rooms, items: 8)
  end

  def show
    @new_message = Message.new
    @room = Room.find(params[:id])
    @pagy, @messages = pagy(@room.messages.order(created_at: :desc).includes(:user), items: 5)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    @room.save ? redirect_to(@room, notice: 'Room was successfully created.') : render(:new)
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
