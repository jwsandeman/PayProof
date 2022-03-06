class HomeController < ApplicationController
  def page
    @jobs = Job.all
  end
end
