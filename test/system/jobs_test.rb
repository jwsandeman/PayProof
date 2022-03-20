require 'application_system_test_case'

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = jobs(:one)
  end

  test 'visiting the index' do
    visit jobs_url
    assert_selector 'h1', text: 'Jobs'
  end

  test 'creating a Job' do
    visit jobs_url
    click_on 'New Job'

    fill_in 'Description', with: @job.description
    fill_in 'Homeowner', with: @job.homeowner_id
    check 'Paid on time' if @job.paid_on_time
    fill_in 'Postcode', with: @job.postcode
    fill_in 'Price', with: @job.price
    fill_in 'State', with: @job.state
    fill_in 'Status', with: @job.status
    fill_in 'Street address', with: @job.street_address
    fill_in 'Suburb', with: @job.suburb
    check 'Successful' if @job.successful
    fill_in 'Title', with: @job.title
    fill_in 'Tradie', with: @job.tradie_id
    click_on 'Create Job'

    assert_text 'Job was successfully created'
    click_on 'Back'
  end

  test 'updating a Job' do
    visit jobs_url
    click_on 'Edit', match: :first

    fill_in 'Description', with: @job.description
    fill_in 'Homeowner', with: @job.homeowner_id
    check 'Paid on time' if @job.paid_on_time
    fill_in 'Postcode', with: @job.postcode
    fill_in 'Price', with: @job.price
    fill_in 'State', with: @job.state
    fill_in 'Status', with: @job.status
    fill_in 'Street address', with: @job.street_address
    fill_in 'Suburb', with: @job.suburb
    check 'Successful' if @job.successful
    fill_in 'Title', with: @job.title
    fill_in 'Tradie', with: @job.tradie_id
    click_on 'Update Job'

    assert_text 'Job was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Job' do
    visit jobs_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Job was successfully destroyed'
  end
end
