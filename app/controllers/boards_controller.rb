class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]
  # before_action { authorize @board || Board }
  before_action :authorize_resource

  # GET /boards or /boards.json
  def index
    @boards = policy_scope(current_user.boards)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /boards/1 or /boards/1.json
  def show
    @pendings = @board.job_listings.where(status: :pending).order(created_at: :desc)
    @under_reviews = @board.job_listings.where(status: :under_review).order(created_at: :desc)
    @interviewings = @board.job_listings.where(status: :interviewing).order(created_at: :desc)
    @rejections = @board.job_listings.where(status: :rejected).order(created_at: :desc)
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id

    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_path, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:board_name)
  end

  def authorize_resource
    #is authorized as a class since there's no specific board instance to authorize.
    if %w[index new create].include?(action_name)
      authorize Board
    else
      authorize @board
    end
  end
end
