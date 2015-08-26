require 'rails_helper'

RSpec.feature "Editing an Article" do
  
  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as john
    @article = Article.create(title: "First Article", body: "body of first article", user: john)
  end
  
  scenario "A user updates an article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"
    
    fill_in "Title", with: "Updated article"
    fill_in "Body", with: "Updated body of article"
    
    click_button "Update Article"
    
    expect(page).to have_content "Article has been updated"
    expect(current_path).to eq article_path(@article)

    @article.reload
    expect(page).to have_content "Updated article"
    expect(page).to have_content "Updated body of article"
    expect(@article.title).to eq "Updated article"
    expect(@article.body).to eq "Updated body of article"
  end
  
  scenario "A user fails to update an article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"
    
    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body of article"
    
    click_button "Update Article"
    
    expect(page).to have_content "Article has not been updated"
    expect(current_path).to eq article_path(@article)

    @article.reload
    expect(@article.title).to eq "First Article"
    expect(@article.body).to eq "body of first article"  
  end
  
end