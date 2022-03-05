class User < ApplicationRecord
  # double relationship references for job table
  has_many :tradie_jobs, class_name: 'Job', foreign_key: 'tradie_id'
  has_many :homeowner_jobs, class_name: 'Job', foreign_key: 'homeowner_id'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
