class User < ApplicationRecord
  # double relationship references for job table
  has_many :tradie_jobs, class_name: 'Job', foreign_key: 'tradie_id'
  has_many :homeowner_jobs, class_name: 'Job', foreign_key: 'homeowner_id'

  # allows user to attached a profile picture
  has_one_attached :profile_pic

  # allows a user to have many reviews
  has_many :reviews
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # find out the payproof score of a user  
  def payproof_score
    if self.tradie?
      @closed_jobs = self.tradie_jobs.status_closed.count
      @successful_jobs = 0
      self.tradie_jobs.each do |job|
        if job.successful
          @successful_jobs += 1
        end
      end
      @payproof_score = (@successful_jobs / @closed_jobs) * 100
    else
      @closed_jobs = self.homeowner_jobs.status_closed.count
      @paid_jobs = 0
      self.homeowner_jobs.each do |job|
        if job.paid_on_time
          @paid_jobs += 1
        end
      end
      @payproof_score = (@paid_jobs / @closed_jobs) * 100
    end
  end

end
