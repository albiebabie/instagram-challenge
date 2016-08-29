def sign_in_1
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: 'email@test.com'
  fill_in 'Password', with: '123456'
  click_button 'Log in'
end

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
  fill_in 'Caption', with: 'Photo without image'
  click_button 'Create Photo'
end

def add_photo_without_caption
  click_link 'Add Photo'
  attach_file 'Image', '/Users/Albie/Desktop/test_image.jpg'
  click_button 'Create Photo'
end
