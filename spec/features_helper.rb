def add_photo_1
  click_link 'Add Photo'
  attach_file 'Image', '/Users/Albie/Desktop/test_image.jpg'
  fill_in 'Caption', with: 'Photo One'
  click_button 'Create Photo'
end

def add_photo_2
  click_link 'Add Photo'
  attach_file 'Image', '/Users/Albie/Desktop/test_2.jpg'
  fill_in 'Caption', with: 'Photo Two'
  click_button 'Create Photo'
end

def add_photo_without_image
  click_link 'Add Photo'
  fill_in 'Caption', with: 'No image'
  click_button 'Create Photo'
end
