require "openai"

class AiMessagesController < ApplicationController


  before_action :set_ai_message, only: %i[ show edit update destroy ]

  # GET /ai_messages or /ai_messages.json
  def index
    @ai_messages = AiMessage.all.order(created_at: :desc).group_by { |message| message.created_at.to_date }
  end

  # GET /ai_messages/1 or /ai_messages/1.json
  def show
  end

  # GET /ai_messages/new
  def new
    @ai_message = AiMessage.new
  end

  # GET /ai_messages/1/edit
  def edit
  end

  # POST /ai_messages or /ai_messages.json
  def create
    @ai_message = AiMessage.new(ai_message_params)
    @ai_message.role << current_user.username
    @ai_message.body << params[:ai_message][:body]
    @ai_message.job_listing_id = params[:job_listing_id]

    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", 
        messages: [{ role: "user", content: @ai_message.body[0] }], # Required.
        temperature: 0.7,
      },
    )

    @ai_message.role << "system"
    @ai_message.body << response["choices"][0]["message"]["content"]

    respond_to do |format|
      if @ai_message.save
        format.html { redirect_to ai_message_url(@ai_message), notice: "Ai message was successfully created." }
        format.json { render :show, status: :created, location: @ai_message }
        format.turbo_stream { render turbo_stream: turbo_stream.append(@ai_message) }
      else
        flash[:error] = @ai_message.errors.full_messages.to_sentence
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ai_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ai_messages/1 or /ai_messages/1.json
  def update
    respond_to do |format|
      if @ai_message.update(ai_message_params)
        format.html { redirect_to ai_message_url(@ai_message), notice: "Ai message was successfully updated." }
        format.json { render :show, status: :ok, location: @ai_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ai_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ai_messages/1 or /ai_messages/1.json
  def destroy
    @ai_message.destroy

    respond_to do |format|
      format.html { redirect_to ai_messages_url, notice: "Ai message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ai_message
    @ai_message = AiMessage.find(params[:id])
  end

  def ai_message_params
    params.require(:ai_message).permit(:role, :body, :job_listing_id)
  end
  
  
end
