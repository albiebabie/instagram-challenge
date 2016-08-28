require 'rails_helper'

feature 'Photos' do
  context 'have not been added' do
    scenario 'should display a prompt to add a photo' do
      visit '/photos'
      expect(page).to have_content 'No photos yet'
      expect(page).to have_link 'Add photo'
    end
  end
  context 'can be added' do
    scenario 'should display uploaded photos' do
      visit '/photos'
      click_link 'Add photo'
      attach_file('Image','/Users/Albie/Desktop/test_image.jpg')
      fill_in 'Caption', with: 'Cheeky'
      click_button 'Create Photo'
      expect(page).to have_content('Cheeky')
      expect(page).to have_css("img[src*='test_image.jpg']")
      click_link 'Add photo'
      attach_file('Image', '/Users/Albie/Desktop/test_2.jpg')
      fill_in 'Caption', with: 'Wave'
      click_button 'Create Photo'
      expect(page).to have_content('Wave')
      expect(page).to have_css("img[src*='test_2.jpg']")
    end
  end
end
