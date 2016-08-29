require 'rails_helper'

feature 'Comments:' do
  before do
    User.create(email: 'email@test.com', password: '123456')
  end
  scenario "users can comment on a photo if they are logged in" do
    visit '/'
    sign_in_1
    add_photo_1
    click_link 'Add Comment'
    fill_in 'Comment', with: 'Awesome smile mate'
    click_button 'OK'
    expect(current_path).to eq('/photos')
    expect(page).to have_content('Awesome smile mate')
  end
end
