class ChatsController < ApplicationController

  # GET /chats
  # GET /chats.json
  def index
    @chats = Chat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chats }
    end
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    @chat = Chat.find(params[:id])

    @chat = Chat.init_session(@chat)
    @tok_token = Chat.gen_token(@chat)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chat }
    end
  end

  # GET /chats/new
  # GET /chats/new.json
  def new
    @chat = Chat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chat }
    end
  end

  # GET /chats/1/edit
  def edit
    @chat = Chat.find(params[:id])
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.new(params[:chat])

    respond_to do |format|
      if @chat.save
        format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
        format.json { render json: @chat, status: :created, location: @chat }
      else
        format.html { render action: "new" }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chats/1
  # PUT /chats/1.json
  def update
    @chat = Chat.find(params[:id])

    respond_to do |format|
      if @chat.update_attributes(params[:chat])
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to chats_url }
      format.json { head :no_content }
    end
  end


  def send_message
    @chat = Chat.find(params[:id])
    @chat.messages.new(:content => params[:chat][:message][:content], :user_id => current_user.id)

    respond_to do |format|
      if @chat.save
        format.js
      else
        
      end

    end
  end


end
