class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[ show edit update destroy ]

  # GET /interviews or /interviews.json
  def index

    @interviews = JobListing.joins(board: :user).where(users: { id: current_user.id }).interviews
    @jo
  end

  # GET /interviews/1 or /interviews/1.json
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews or /interviews.json
  def create
    @interview = Interview.new(interview_params)
    @job_listing = JobListing.find(@interview.job_listing_id)
    respond_to do |format|
      if @interview.save
        format.html { redirect_to job_listing_path(@interview.job_listing_id), notice: "Interview was successfully created." }
        format.json { render :show, status: :created, location: @interview }
      else
        #format.html {  render partial: 'form', locals: { interview: @interview, job_listing: @job_listing }, status: :unprocessable_entity}
        format.html { redirect_back fallback_location: job_listing_path(@interview.job_listing_id), alert: "#{@interview.errors.full_messages.join(',')}" }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to job_listing_url(@interview.job_listing_id), notice: "Interview was successfully updated." }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html {redirect_back(fallback_location: job_listing_url(@interview.job_listing_id), alert: "Unable to update the record. Please check your input.")}
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1 or /interviews/1.json
  def destroy
    interview = Interview.find(params[:id])
    job_listing_id = interview.job_listing_id
    @interview.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: job_listing_url(job_listing_id), notice: "Interview was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interview_params
      params.require(:interview).permit(:interview_type, :details, :start_date, :end_date, :point, :job_listing_id)
    end
end
