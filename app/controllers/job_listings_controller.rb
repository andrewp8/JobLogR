class JobListingsController < ApplicationController
  before_action :set_job_listing, only: %i[ show edit update update_status destroy ]

  # GET /job_listings or /job_listings.json
  def index
    @job_listings = JobListing.all
  end

  # GET /job_listings/1 or /job_listings/1.json
  def show
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
        # format.html { redirect_to job_listing_url(@job_listing), notice: "Job listing was successfully created." }
        format.html { redirect_back fallback_location: board_path(@job_listing.board.id), notice: "Job listing was successfully created." }
        format.json { render :show, status: :created, location: @job_listing }
      else
        format.html { redirect_back fallback_location: board_path(@job_listing.board.id), alert: "#{@job_listing.errors.full_messages.join(',')}" }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_listings/1 or /job_listings/1.json
  def update
    respond_to do |format|
      if @job_listing.update(job_listing_params)
        format.html { redirect_to job_listing_url(@job_listing), notice: "Job listing was successfully updated." }
        format.json { render :show, status: :ok, location: @job_listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    params.require(:job_listing).permit(:title, :company, :location, :salary, :status, :details, :details_summary, :applicant_id, :points, :board_id, :job_url, :portal_url)
  end
end
