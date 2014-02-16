class MicropostsController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    before_action :filter_message, only: :create
    before_action :filter_reply, only: :create

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate page: params[:page]
            render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        redirect_to root_url
    end

private
    
    def micropost_params 
        params.require(:micropost).permit(:content)
    end

    def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        retdirect_to root_url if @micropost.nil?
    end

    def filter_message
        c = params[:micropost][:content]
        m = c.match(/\Ad\s+@(\S+)/)
        if m 
            u = User.find_by_name(m[1].gsub('-',' '))
            if !u
                flash[:danger] = "User not found!"
                @micropost = current_user.microposts.build micropost_params
                @feed_items = current_user.feed.paginate page: params[:page]
                render 'static_pages/home'
                return
            end
            if current_user.outgoing_messages.create content: c, to: u
                flash[:success] = "Message send!"
                redirect_to root_url
            end
        end  
    end

    def filter_reply
    end

end