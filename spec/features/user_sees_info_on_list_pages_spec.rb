require 'rails_helper'

describe "as a user" do
  describe 'when visiting /lists' do
    it 'shows all lists on index page' do
      list_1 = List.create(title: "Some Stuff")
      list_2 = List.create(title: "Some More Stuff")

      visit lists_path

      expect(page).to have_content("Lists")
      expect(page).to have_content("Title")
      expect(page).to have_content("#{list_1.title}")
      expect(page).to have_content("#{list_2.title}")

      expect(page).to have_link("Show", :href=>"/lists/#{list_1.id}")
      expect(page).to have_link("Show", :href=>"/lists/#{list_2.id}")
      expect(page).to have_link("Edit", :href=>"/lists/#{list_1.id}/edit")
      expect(page).to have_link("Edit", :href=>"/lists/#{list_2.id}/edit")
      expect(page).to have_link("Destroy", :href=>"/lists/#{list_1.id}")
      expect(page).to have_link("Destroy", :href=>"/lists/#{list_2.id}")

      expect(page).to have_link("New List", :href=>"/lists/new")
    end
  end
  describe 'when visiting /lists/:id' do
    it 'shows list info on show page' do
      list_1 = List.create(title: "Some Stuff")

      visit list_path(list_1)

      expect(page).to have_content("Title: #{list_1.title}")

      expect(page).to have_link("Tasks", :href=>"/lists/#{list_1.id}/tasks")
      expect(page).to have_link("Edit", :href=>"/lists/#{list_1.id}/edit")
      expect(page).to have_link("All Lists", :href=>"/lists")
    end
  end
  describe 'when visiting /lists/new' do
    it 'creates a new list' do
      list_1 = List.new()

      visit new_list_path(list_1)

      expect(page).to have_content("New list")
      expect(page).to have_content("Title")
      expect(page).to have_field("Title")
      expect(page).to have_link("All Lists", :href=>"/lists")
      fill_in 'Title', with: 'New List'
      click_button 'Create List'

      expect(page.current_path).to eq("/lists/1")
    end
  end
  describe 'when editing a list' do
    it 'shows edit page and updates list' do
      list_1 = List.create(title: "New List")

      visit edit_list_path(list_1)

      expect(page).to have_content("Editing list")
      expect(page).to have_content("Title")
      expect(page).to have_field("Title")
      expect(page).to have_link("Show", :href=>"/lists/#{list_1.id}")
      expect(page).to have_link("All Lists", :href=>"/lists")
      fill_in 'Title', with: 'Newer List'
      click_button 'Update List'

      expect(page.current_path).to eq(list_path(list_1))
      expect(page).to have_content("List Newer List was successfully updated.")
      expect(page).to have_content("Title: Newer List")
    end
  end
  describe 'when deleting a list' do
    it 'redirects to index and shows deleted list message' do
      list_1 = List.create(title: "New List")

      visit lists_path

      click_link 'Destroy'
      expect(page.current_path).to eq(lists_path)

      expect(page).to have_content("List New List was successfully deleted.")

      expect(List.all.count).to eq(0)
    end
  end
end
