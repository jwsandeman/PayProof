class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: %i[ show edit update destroy update_job user_reviews ]
  before_action :check_user, only: [:show]
  before_action :check_ownership, only: [:edit, :update, :update_job, :destroy]
  before_action :user_reviews, only: [:show]

  # GET /jobs or /jobs.json
  def index
    # this checks if the current user is a tradie
    if current_user.tradie 
      # this selects only jobs that belong to the current user (tradie) 
      @jobs = Job.all.select {|job| job.tradie_id == current_user.id} 
    else
      # this selects only jobs that belong to the current user (homeowner) 
      @jobs = Job.all.select {|job| job.homeowner_id == current_user.id}
    end
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)
    @job.homeowner_id = current_user.id

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      # this checks if the update was successful
      if @job.update(job_params)
        if @job.status_active? && current_user.tradie?
          # sets the current user as the tradie of the job once they submit a quote
          @job.update(tradie_id: current_user.id)
        end
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_job
    if @job.update(status: params[:status])
      redirect_to job_url(@job), alert: "Job was cancelled."
    else
      redirect_to jobs_url, alert: "Job was not cancelled, please try again."
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def user_reviews
    @user_reviews = 0
    @job.reviews.each do |review|
      if current_user.id == review.user_id
        @user_reviews += 1
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :street_address, :suburb, :postcode, :state, :price, :status, :successful, :paid_on_time, :payment_terms, :quote, photos: [], completion_photos: [])
    end

    def check_user
      if !@job.status_open? && !@job.successful
        if current_user.tradie?
          if current_user.id != @job.tradie_id
            redirect_to root_url, alert: "You do not have access to that job"
          end
        else
          if current_user.id != @job.homeowner_id
            redirect_to root_url, alert: "You do not have access to that job"
          end
        end
      end
    end

    def check_ownership
      if current_user.tradie?
        if current_user.id != @job.tradie_id
          redirect_to root_url, alert: "You do not have access to that job"
        end
      else
        if current_user.id != @job.homeowner_id
          redirect_to root_url, alert: "You do not have access to that job"
        end
      end
    end 
end
