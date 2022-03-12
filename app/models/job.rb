class Job < ApplicationRecord
  # double relationship references for user table
  belongs_to :tradie, class_name: 'User', optional: true
  belongs_to :homeowner, class_name: 'User'

  # enables many files to be attached and associated with the job model
  has_many_attached :photos

  # enables many job completion files to be attached and associated with the job model
  has_many_attached :completion_photos

  # enables one quote file to be attached
  has_one_attached :quote

  # allows a job to have many reviews
  has_many :reviews

  # Enums for status variable (open, active, closed)
  # job.status_active?    # Returns true if job.status == 'active'
  # job.status_open!      # same as job.update(status: :open)
  # job.status_closed     # Job.where(status: :closed)
  enum status: {
    open: 0,
    active: 1,
    verified: 2,
    finished: 3,
    sent: 4,
    closed: 5
  }, _prefix: true

  def full_address
    "#{self.street_address} #{self.suburb.capitalize} #{self.postcode} #{self.state} "
  end
end 
