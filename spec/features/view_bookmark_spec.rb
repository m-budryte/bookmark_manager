feature 'Viewing the index page' do
  scenario 'When we go to the home page' do
    visit '/'
    
    expect(page).to have_content("Hello, world")
  end
end
