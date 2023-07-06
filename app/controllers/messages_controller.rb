class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

 def create
  
  if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
  @message = Message.create(user_id: current_user.id, body: params[:message][:message], room_id: params[:message][:room_id])
    redirect_to "/rooms/#{@message.room_id}"
  else
    redirect_back(fallback_location: root_path)
  end
 end
end
    private 
    def message_params
        params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id)
    end
