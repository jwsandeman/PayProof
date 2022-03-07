class ProfileController < ApplicationController
  before_action :set_user

  def page
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
    # @job = Job.find(params[:id])
    @user = User.find(params[:id])
  end

end
