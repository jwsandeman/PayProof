class ProfileController < ApplicationController
  before_action :set_user

  def page
    @reviews = Review.all
    @user_reviews = []
    @ratings = []

    # loops through all reviews
    @reviews.each do |review|
      # the tradie that worked on the job but not that tradies reviews
      if review.job.tradie == @user && review.user.id != @user.id
        # add the review rating into the ratings array
        @ratings << review.rating
        # add the review into the user_reviews array
        @user_reviews << review
      # the homeowner that worked on the job but not the homeowners reviews
      elsif review.job.homeowner == @user && review.user.id != @user.id
        # add the review rating into the ratings array
        @ratings << review.rating
        # add the review into the user_reviews array
        @user_reviews << review
      end
    end
  end

  def jobs
    # @jobs = Job.find(user.id)
    if @user.tradie 
      # this selects only jobs that belong to the set user's profile (tradie) 
      @jobs = Job.all.select {|job| job.tradie_id == @user.id && job.status_closed? }
    else
      # this selects only jobs that belong to the set user's profile (homeowner) 
      @jobs = Job.all.select {|job| job.homeowner_id == @user.id && job.status_open? }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
