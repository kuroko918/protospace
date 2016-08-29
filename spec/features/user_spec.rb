require 'rails_helper'

RSpec.feature "User" do
  given(:user) { build(:user) }
  given(:prototype) { build(:prototype, :prototype_with_main_image) }

  def sign_up
    visit root_path
    click_link 'Get Started'
    click_link 'Sign up now'
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_member', with: user.member
    fill_in 'user_profile', with: user.profile
    fill_in 'user_works', with: user.works
    click_button 'Save'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  def sign_in
    visit root_path
    click_on 'Get Started'
    fill_in 'Email address', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'Sign in'
  end

  scenario 'user sign_up' do
    sign_up
  end

  scenario 'user login and create a new prototype', js: true do
    sign_in
    click_on 'New Proto'
    fill_in 'prototype_title', with: prototype.title
    attach_file 'prototype[images_attributes][0][image]', "spec/fixtures/img/sample.jpg"
    1.upto(3) do |i|
      attach_file "prototype[images_attributes][#{i}][image]", "spec/fixtures/img/sample.jpg"
    end
    fill_in 'prototype_catch_copy', with: prototype.catch_copy
    fill_in 'prototype_concept', with: prototype.concept
    click_on 'Publish'
    expect(page).to have_content 'exactly saved'
  end
end
