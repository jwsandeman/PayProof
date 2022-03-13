class HomeController < ApplicationController

  # sets all jobs for the home page
  def page
    @jobs = Job.all
    @term = params["search_term"]
    if @term.present?
      @suburb = @term["suburb"]
      @jobs = Job.where("lower(suburb) LIKE ?", "%#{@suburb.downcase}%")
    end
  end

  private
  # not sure if i need this?
  def job_params
    params.require(:job).permit(:search_term)
  end

end
