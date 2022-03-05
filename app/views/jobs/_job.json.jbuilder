json.extract! job, :id, :title, :description, :street_address, :suburb, :postcode, :state, :price, :status, :successful, :paid_on_time, :payment_terms :tradie_id, :homeowner_id, :created_at, :updated_at
json.url job_url(job, format: :json)
