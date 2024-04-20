class JobListingsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_job_listing, only: %i[ show edit update update_status destroy ]

  # GET /job_listings or /job_listings.json
  def index
    @job_listings = JobListing.joins(board: :user).where(users: { id: current_user.id })
  end

  # GET /job_listings/1 or /job_listings/1.json
  def show
    @follow_up_template = JobListing.follow_up_email_template
  end

  # GET /job_listings/new
  def new
    @job_listing = JobListing.new
  end

  # GET /job_listings/1/edit
  def edit
  end

  # POST /job_listings or /job_listings.json
  def create
    @job_listing = JobListing.new(job_listing_params)
    respond_to do |format|
      if @job_listing.save
        format.html { redirect_back fallback_location: board_path(@job_listing.board.id), notice: "Job listing was successfully created." }
        format.json { render :show, status: :created, location: @job_listing }
      else
        format.html { redirect_back fallback_location: board_path(@job_listing.board.id), alert: "#{@job_listing.errors.full_messages.join(",")}" }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_listings/1 or /job_listings/1.json
  def update
    if params[:job_listing][:attachments].present?
      params[:job_listing][:attachments].each do |attachment|
        @job_listing.attachments.attach(attachment)
      end
    end
    respond_to do |format|
      if @job_listing.update(job_listing_params)
        format.html { redirect_to job_listing_url(@job_listing), notice: "Job listing was successfully updated." }
        format.json { render :show, status: :ok, location: @job_listing }
      else
        format.html { redirect_back(fallback_location: job_listing_url(@job_listing), alert: "Unable to update the record. Please check your input.") }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    new_status = params[:status].to_sym
    @job = set_job_listing()
    respond_to do |format|
      if JobListing.statuses.key?(new_status)
        @job.update(status: new_status)
        format.html { redirect_to board_path(@job.board), notice: "Status updated successfully." }
        format.js
      else
        format.html { redirect_to board_path(@job.board), alert: "Invalid status." }
      end
    end
  end

  def application_insights
    @job_listings = index
    @follow_up_list = @job_listings.where("job_listings.total_points < 1 AND job_listings.created_at >= ?", 6.months.ago)
    @six_months_progress = @job_listings.where("job_listings.created_at <= ?", 6.months.ago).count.presence || 0
    @num_of_interviews_in_six_months = @job_listings.where(status: :interviewing).where("job_listings.created_at <= ?", 6.months.ago).count.presence || 0
    @last_seven_days_progress = @job_listings.where("job_listings.created_at >= ?", 7.days.ago)
    @total_interviewings = @job_listings.where(status: :interviewing).count
    @total_under_reviews = @job_listings.where(status: :under_review).count
    @total_pendings = @job_listings.where(status: :pending).count
    @total_rejections = @job_listings.where(status: :rejected).count
    
    respond_to do |format|
      format.html { render "job_listings/charts/charts" }
    end
  end

  # DELETE /job_listings/1 or /job_listings/1.json
  def destroy
    board_id = @job_listing.board.id
    @job_listing.destroy

    respond_to do |format|
      format.html { redirect_to board_path(board_id), notice: "The job listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job_listing
    @job_listing = JobListing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_listing_params
    params.require(:job_listing).permit(:title, :company, :location, :salary, :status, :details, :details_summary, :points, :board_id, :job_url, :portal_url, attachments: [])
  end
end
