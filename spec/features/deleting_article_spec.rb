require 'rails_helper'

RSpec.feature "Deleting an Aritcle" do
  
  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as john
    @article = Article.create(title: "First article", body: "Body of first article", user: john)
  end
  
  scenario "A user deletes an article" do
    visit "/"
    
    click_link @article.title
    
    click_link "Delete Article"
    
    expect(page).to have_content "\"#{@article.title}\" has been deleted"
    expect(current_path).to eq articles_path
  end

end