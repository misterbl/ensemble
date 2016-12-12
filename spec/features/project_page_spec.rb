require 'rails_helper'

RSpec.feature 'User creates new project', :type => :feature do

  before(:each) do
    sign_in
  end

  scenario 'user can see project creation page' do
    visit new_project_path
    expect(page).to have_content 'New Project'
  end

  scenario 'user can input project details' do
    visit new_project_path
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Genre'
    expect(page).to have_content 'Description'
    page.has_button? 'Create Project'
  end

  scenario 'user can created a new project' do
    visit new_project_path
    fill_in 'project_title', with: 'Moon Beam'
    fill_in 'project_genre', with: 'Jazz'
    fill_in 'project_description', with: 'Free flowing funk'
    click_button 'Create Project'

    expect(page).to have_content 'Project created successfully'
  end


  scenario 'user must input title of project to create project' do
    visit new_project_path
    fill_in 'project_genre', with: 'Jazz'
    fill_in 'project_description', with: 'Free flowing funk'
    click_button 'Create Project'

    expect(page).to have_content 'Please enter a project title'
  end

  scenario "delete projects" do
    visit new_project_path

    fill_in 'project_title', with: 'Moon Beam'
    fill_in 'project_genre', with: 'Jazz'
    fill_in 'project_description', with: 'Free flowing funk'
    click_button 'Create Project'
    expect{ click_link_or_button 'Delete Project' }.to change{ Project.count }.by(-1)
    expect(page).to have_content "Project deleted"

  end

  context "Mix request" do
    it 'button is present on page after contributing user sends request' do
      create_branch_as_user_3
      fill_in 'Mix Request', with: "Please Accept"
      click_link_or_button("Create Request")
      sign_out
      sign_in
      visit('projects/1000')
      expect(page).to have_button('Approve')
      expect(page).to have_button('Reject')
    end

    it 'project owner can merge tracks', focus: true do
      create_branch_as_user_3
      fill_in 'Mix Request', with: "Please Accept"
      click_link_or_button("Create Request")
      sign_out
      sign_in
      visit('projects/1000')
      click_link_or_button("Approve")
      expect(page).to have_content("Approved mix")
    end

  end


end
