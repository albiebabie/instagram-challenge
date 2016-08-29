require 'rails_helper'

feature 'Reviews' do
  scenario 'users can comment on a photo' do
    visit '/photos'
    add_photo_1
    click_link 'Add Comment'
    fill_in 'Comment', with: 'Awesome smile mate'
    click_button 'OK'
    expect(current_path).to eq('/photos')
    expect(page).to have_content('Awesome smile mate')
  end
end
