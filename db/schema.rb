# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_312_012_437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'jobs', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'description', null: false
    t.string 'street_address', null: false
    t.string 'suburb', null: false
    t.string 'postcode', null: false
    t.string 'state', null: false
    t.float 'price'
    t.integer 'status', default: 0
    t.boolean 'successful'
    t.boolean 'paid_on_time'
    t.integer 'payment_terms', default: 7
    t.bigint 'tradie_id'
    t.bigint 'homeowner_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['homeowner_id'], name: 'index_jobs_on_homeowner_id'
    t.index ['tradie_id'], name: 'index_jobs_on_tradie_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'rating'
    t.text 'comment'
    t.bigint 'job_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['job_id'], name: 'index_reviews_on_job_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'username'
    t.string 'name'
    t.string 'street_address'
    t.string 'suburb'
    t.string 'postcode'
    t.string 'state'
    t.string 'phone_number'
    t.string 'bio'
    t.boolean 'tradie', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'jobs', 'users', column: 'homeowner_id'
  add_foreign_key 'jobs', 'users', column: 'tradie_id'
  add_foreign_key 'reviews', 'jobs'
  add_foreign_key 'reviews', 'users'
end
