class MessagesController < ApplicationController
  
  def create
    message = current_user.messages.build(message_params)
    if message.save
      redirect_to root_path
    else
      flash[:error] = "Message must not be empty"
      redirect_to root_path
    end
  end
  private

  def message_params
    params.require(:message).permit(:body)
  end
end
