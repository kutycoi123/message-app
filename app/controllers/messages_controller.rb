class MessagesController < ApplicationController
  
  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast "chatroom_channel", 
                                   mod_message: message_render(message)
    else
      flash[:error] = "Message must not be empty"
      redirect_to root_path
    end
  end
  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
