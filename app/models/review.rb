class Review < ApplicationRecord
  # creates association to job
  belongs_to :job
  # creates association to user
  belongs_to :user
end
