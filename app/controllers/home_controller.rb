class HomeController < ApplicationController
  def page
    # sets all jobs for the home page
    @jobs = Job.all
    # sets the search term
    @term = params['search_term']
    # checks if there is a search term present
    if @term.present?
      # sets term to the suburb attribute
      @suburb = @term['suburb']
      # returns all jobs where subrub == search term
      @jobs = Job.where('lower(suburb) LIKE ?', "%#{@suburb.downcase}%")
    end

    # displays only jobs that are open or successful
    @jobs = @jobs.select { |job| job.status_open? || job.successful }
  end
end
