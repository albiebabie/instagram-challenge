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
    scenario 'displays the new photo on the index page' do
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
      expect(page).not_to have_content('Photo without image')
    end

    # scenario 'if user does not upload a photo with a caption' do
    #   visit '/photos'
    #   add_photo_without_caption
    #   expect(page).to have_content('Whoops... you forgot to add a caption!')
    #   expect(page).not_to have_css("img[src*='test_image.jpg']")
    # end
  end

  context 'viewing photos' do

    # let!(:photo){ Photo.create( image_file_name: "/Users/Albie/Desktop/test_image.jpg", caption: 'Photo One') }

    scenario 'lets a user view individual photos' do
      visit '/photos'
      add_photo_1
      add_photo_2
      find("img[@alt='Test image']").click
      expect(page).to have_css("img[src*='test_image.jpg']")
      expect(page).to have_content("Photo One")
      expect(page).not_to have_content("Wave")
      expect(page).not_to have_css(("img[src*='test_image_2.jpg']"))
      # expect(current_path).to eq("/photos/#{photo.id}")
    end
  end

  context 'editing photos' do
    scenario 'displays an edit link, which allows user to edit caption' do
      visit '/photos'
      add_photo_1
      click_link 'Edit Photo'
      fill_in 'Caption', with: 'This caption has been edited'
      click_button 'Update Photo'
      expect(page).not_to have_content('Photo One')
      expect(page).to have_content('This caption has been edited')
      expect(page).to have_css("img[src*='test_image.jpg']")
    end
  end
end
