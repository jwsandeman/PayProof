class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_job
  before_action :find_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # set the job id
    @review.job_id = @job.id
    # set the user id
    @review.user_id = current_user.id

    # redirect to job on successful review save
    if @review.save
      redirect_to job_path(@job), notice: "Review was successfully created."
    else
      render 'new', alert: "Unable to create review."
    end
  end

  def edit
  end

  def update
    # redirect to job on successful review update
    if @review.update(review_params)
      redirect_to job_path(@job), notice: "Review was successfully updated."
    else 
      render 'edit', alert: "Unable to update review."
    end
  end

  def destroy
    @review.destroy
    redirect_to job_path(@job), notice: "Review was successfully deleted."
  end

  private

  # sets allowable parameters
  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  # finds the job based on the job id parameter
  def find_job
    @job = Job.find(params[:job_id])
  end

  # finds the review based on the id paramters
  def find_review
    @review = Review.find(params[:id])
  end

end
