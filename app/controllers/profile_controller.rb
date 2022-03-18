class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def page
    # find the reviews for the set_users profile page
    @reviews = Review.all
    # set_users reviews
    @user_reviews = []
    # all of set_users individual ratings
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
    # the average rating of set_user
    @average_rating = @ratings.sum.to_f / @ratings.count.to_f

    # find the jobs for the set_users profile page
    if @user.tradie 
      # this selects only jobs that belong to the set user's profile (tradie) 
      @jobs = Job.all.select {|job| job.tradie_id == @user.id && job.status_closed? }
    else
      # this selects only jobs that belong to the set user's profile (homeowner) 
      @jobs = Job.all.select {|job| job.homeowner_id == @user.id && job.status_open? }
    end

    # find out the payproof score of a user
    if @user.tradie?
      @closed_jobs = @user.tradie_jobs.status_closed.count
      @successful_jobs = 0
      @user.tradie_jobs.each do |job|
        if job.successful
          @successful_jobs += 1
        end
      end
      @payproof_score = (@successful_jobs.to_f / @closed_jobs.to_f) * 100
    else
      @closed_jobs = @user.homeowner_jobs.status_closed.count
      @paid_jobs = 0
      @user.homeowner_jobs.each do |job| 
        if job.paid_on_time
          @paid_jobs += 1
        end
      end
      @payproof_score = (@paid_jobs.to_f / @closed_jobs.to_f) * 100
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
