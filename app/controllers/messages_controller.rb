class MessagesController < ApplicationController
    before_action :correct_user

    def index
        @title = "Messages"
        @messages = @user.all_messages.paginate page: params[:page]
    end

    def destroy
        @title = "Messages"
        Message.find(params[:id]).destroy
        redirect_to user_messages_path(@user)
    end

private
    
    def correct_user
        @user = User.find(params[:user_id])
        redirect_to root_url unless current_user? @user
    end
end
