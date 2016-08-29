require 'rails_helper'

feature 'Photos:' do

  context 'When none have been added' do

    scenario 'will prompt user to add a Photo' do
      visit '/photos'
      expect(page).to have_content 'No Photos yet'
      expect(page).to have_link 'Add Photo'
    end
  end

  context 'if user is signed up and signed in they' do
    before do
      User.create(email: "email@test.com", password: "123456")
    end
    scenario 'can add a photo' do
      sign_in_1
      add_photo_1
      expect(current_path).to eq('/photos')
      expect(page).to have_content('Photo One')
      expect(page).to have_css("img[src*='test_image.jpg']")
    end
    scenario 'cannot add a photo - if they forget to upload an image file' do
      sign_in_1
      visit '/photos'
      add_photo_without_image
      expect(page).to have_content('Whoops... you forgot to upload an image!')
      expect(page).not_to have_content('Photo without image')
    end
  end

  context 'if user is not signed up and signed in they' do
    scenario 'cannot add a photo' do
      visit '/'
      click_link 'Add Photo'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(current_path).to eq "/users/sign_in"
    end

    # scenario 'if user does not upload a photo with a caption' do
    #   visit '/photos'
    #   add_photo_without_caption
    #   expect(page).to have_content('Whoops... you forgot to add a caption!')
    #   expect(page).not_to have_css("img[src*='test_image.jpg']")
    # end
  end

  context 'viewing photos' do
    before do
      User.create(email: "email@test.com", password: "123456")
    end
    let!(:photo_1){ Photo.create( image_file_name: "/Users/Albie/Desktop/test_image.jpg", caption: 'Photo One') }
    let!(:photo_2){ Photo.create( image_file_name: "/Users/Albie/Desktop/test_2.jpg", caption: 'Photo One') }

    scenario "lets a 'signed out/non signed up' user view individual photos" do
      visit '/photos'
      find("##{photo_1.id}").click
      expect(page).to have_css("img[src*='test_image.jpg']")
      expect(page).to have_content("Photo One")
      expect(page).not_to have_content("Wave")
      expect(page).not_to have_css(("img[src*='test_2.jpg']"))
      expect(current_path).to eq("/photos/#{photo_1.id}")
    end
  end

  context 'editing photos' do
    before do
      User.create(email: "email@test.com", password: "123456")
    end
    scenario 'allows a signed in user to edit a caption' do
      visit '/'
      sign_in_1
      add_photo_1
      click_link 'Edit Photo'
      fill_in 'Caption', with: 'This caption has been edited'
      click_button 'Update Photo'
      expect(page).not_to have_content('Photo One')
      expect(page).to have_content('This caption has been edited')
      expect(page).to have_css("img[src*='test_image.jpg']")
    end

    scenario 'allows a signed in user to change/edit the uploaded image' do
      visit '/'
      sign_in_1
      add_photo_1
      click_link 'Edit Photo'
      attach_file 'Image', '/Users/Albie/Desktop/test_2.jpg'
      click_button 'Update Photo'
      expect(page).to have_content('Photo One')
      expect(page).not_to have_css("img[src*='test_image.jpg']")
      expect(page).to have_css("img[src*='test_2.jpg']")
    end
  end

  context 'deleting photos' do
    before do
      User.create(email: "email@test.com", password: "123456")
    end
    scenario 'can be done by a signed in user' do
      visit '/'
      sign_in_1
      add_photo_1
      click_link 'Delete Photo'
      expect(page).to have_content('Photo deleted successfu')
      expect(page).not_to have_content('Photo One')
      expect(page).not_to have_css("img[src*='test_image.jpg']")
    end
  end
end
