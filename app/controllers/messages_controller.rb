class MessagesController < ApplicationController

  def new
    @message = Message.new
    @user = User.find(params[:user])
  end

  def create
    @message = Message.new(params[:message])
    @message.sender = User.find_by_name(params[:message][:sender])
    @message.recipient = User.find_by_name(params[:message][:recipient])
    @message.subject = params[:message][:subject]
    @message.body = params[:message][:body]

    if @message.save
      flash[:success] = "Message sent"
      redirect_to root_path
    else
      render :action => :new
    end
  end
    
end
