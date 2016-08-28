require 'rails_helper'

feature 'Photos' do

  context 'have not been added' do
    scenario 'should display a prompt to add a Photo' do
      visit '/photos'
      expect(page).to have_content 'No Photos yet'
      expect(page).to have_link 'Add Photo'
    end
  end

  context 'have been added' do
    before do
      Photo.create(caption: 'Test')
      Photo.create(caption: 'Image')
    end

    scenario 'should display the added photos' do
      visit '/photos'
      expect(page).to have_content('Test')
      expect(page).to have_content('Image')
    end
  end
  #
  # context 'have been added' do
  #   scenario 'should display the added photos' do
  #     visit '/photos'
  #     click_link 'Add Photo'
  #     attach_file 'Image', '/Users/Albie/Desktop/test_image.jpg'
  #     fill_in 'Caption', with: 'Cheeky'
  #     click_button 'Create Photo'
  #     click_link 'Add Photo'
  #     attach_file 'Image', '/Users/Albie/Desktop/test_2.jpg'
  #     fill_in 'Caption', with: 'Wave'
  #     click_button 'Create Photo'
  #     expect(page).to have_content('Cheeky')
  #     expect(page).to have_css("img[src*='test_image.jpg']")
  #     expect(page).to have_content('Wave')
  #     expect(page).to have_css("img[src*='test_2.jpg']")
  #   end
  # end
end
