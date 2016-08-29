require 'rails_helper'

feature 'Photos' do

  context 'not added' do
    scenario 'should display a prompt to add a Photo' do
      visit '/photos'
      expect(page).to have_content 'No Photos yet'
      expect(page).to have_link 'Add Photo'
    end
  end

  context 'can be added' do
    scenario 'prompts user to add a photo, then displays the new photo' do
      visit '/photos'
      add_photo_1
      expect(current_path).to eq('/photos')
      expect(page).to have_content('Photo One')
      expect(page).to have_css("img[src*='test_image.jpg']")
    end
  end

  context 'cannot be created' do
    scenario 'if user does not upload an image file' do
      visit '/photos'
      add_photo_without_image
      expect(page).to have_content('Whoops... you forgot to upload an image!')
      expect(page).not_to have_content('No image')
    end
  end

  context 'viewing photos' do
    scenario 'lets a user view individual photos' do
      visit '/photos'
      add_photo_1
      add_photo_2
      find("img[@alt='Test image']").click
      expect(page).to have_css("img[src*='test_image.jpg']")
      expect(page).to have_content("Photo One")
      expect(page).not_to have_content("Wave")
      expect(page).not_to have_css(("img[src*='test_image_2.jpg']"))
    end
  end
end
