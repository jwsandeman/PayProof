class Job < ApplicationRecord
  # double relationship references for user table
  belongs_to :tradie, class_name: 'User', optional: true
  belongs_to :homeowner, class_name: 'User'

  # Enums for status variable (open, active, closed)
  # job.status_active?    # Returns true if job.status == 'active'
  # job.status_open!      # same as job.update(status: :open)
  # job.status_closed     # Job.where(status: :closed)
  enum status: {
    open: 0,
    active: 1,
    closed: 2
  }, _prefix: true
end 
