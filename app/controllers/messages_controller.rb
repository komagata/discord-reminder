# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: %i[edit update destroy]

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def edit; end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to edit_message_path(@message), notice: 'Message was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      redirect_to edit_message_path(@message), notice: 'Message was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path, notice: 'Message was successfully destroyed.'
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(
      :title,
      :schedule,
      :body,
      :channel_id
    )
  end
end
