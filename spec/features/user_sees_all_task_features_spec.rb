require 'spec_helper'

describe "as a user" do
  describe 'when visiting /lists/:id/tasks' do
    it 'shows all tasks on index page' do
      list_1 = List.create(title: "Some Stuff")
      task_1 = list_1.tasks.create(name: "a thing", due_date: "2019-03-03", complete: false)
      task_2 = list_1.tasks.create(name: "another thing", due_date: "2019-04-03", complete: true)

      visit list_tasks_path(list_1)

      expect(page).to have_content("List Tasks")
      expect(page).to have_content("Name")
      expect(page).to have_link("Due Date↓")
      expect(page).to have_content("Complete?")

      expect(page).to have_content("#{task_1.name}")
      expect(page).to have_content("#{task_1.due_date}")
      expect(page).to have_content("#{task_1.complete}")
      expect(page).to have_content("#{task_2.name}")
      expect(page).to have_content("#{task_2.due_date}")
      expect(page).to have_content("#{task_2.complete}")

      expect(page).to have_link("Show", :href=>"/lists/#{list_1.id}/tasks/#{task_1.id}")
      expect(page).to have_link("Show", :href=>"/lists/#{list_1.id}/tasks/#{task_2.id}")
      expect(page).to have_link("Edit", :href=>"/lists/#{list_1.id}/tasks/#{task_1.id}/edit")
      expect(page).to have_link("Edit", :href=>"/lists/#{list_1.id}/tasks/#{task_2.id}/edit")
      expect(page).to have_link("Destroy", :href=>"/lists/#{list_1.id}/tasks/#{task_1.id}")
      expect(page).to have_link("Destroy", :href=>"/lists/#{list_1.id}/tasks/#{task_2.id}")

      expect(page).to have_link("All Lists", :href=>"/lists")
      expect(page).to have_link("New Task", :href=>"/lists/#{list_1.id}/tasks/new")
    end
  end
  describe 'when visiting /lists/:id/tasks/:task_id' do
    it 'shows list info on show page' do
      list = List.create(title: "Some Stuff")
      task = list.tasks.create(name: "a thing", due_date: "2019-03-03", complete: false)

      visit list_task_path(list, task)

      expect(page).to have_content("#{task.name}")
      expect(page).to have_content("Due By: #{task.due_date}")
      expect(page).to have_content("Not Complete")

      expect(page).to have_link("Edit", :href=>"/lists/#{list.id}/tasks/#{task.id}/edit")
      expect(page).to have_link("#{list.title} Tasks", :href=>"/lists/#{list.id}/tasks")
    end
  end
  describe 'when visiting /lists/:id/tasks/new' do
    it 'creates a new task' do
      list = List.create(title: "Some Stuff")
      task = list.tasks.new()

      visit new_list_task_path(list, task)

      expect(page).to have_content("New Task")
      expect(page).to have_content("Name")
      expect(page).to have_field("Name")
      expect(page).to have_content("Due date")
      expect(page).to have_field("Due date")
      expect(page).to have_content("Complete?")
      expect(page).to have_field("Complete")
      expect(page).to have_link("All Tasks", :href=>"/lists/#{list.id}/tasks")
      fill_in 'Name', with: 'New Task'
      fill_in 'Due date', with: '2019-03-03'
      click_button 'Create Task'

      expect(page.current_path).to eq("/lists/#{list.id}/tasks/1")
    end
  end
  describe 'when editing a task' do
    it 'shows edit page and updates task' do
      list = List.create(title: "Some Stuff")
      task = list.tasks.create(name: "a thing", due_date: "2019-03-03", complete: false)

      visit edit_list_task_path(list, task)

      expect(page).to have_content("Editing Task")
      expect(page).to have_content("Name")
      expect(page).to have_field("Name")
      expect(page).to have_content("Due date")
      expect(page).to have_field("Due date")
      expect(page).to have_content("Complete?")
      expect(page).to have_field("Complete")
      expect(page).to have_link("All Tasks", :href=>"/lists/#{list.id}/tasks")
      expect(page).to have_link("Show", :href=>"/lists/#{list.id}/tasks/#{task.id}")
      fill_in 'Name', with: 'Newer Task'
      fill_in 'Due date', with: '2020/03/03'
      check 'Complete'
      click_button 'Update Task'

      expect(page.current_path).to eq(list_task_path(list, task))
      expect(page).to have_content("Task Newer Task was successfully updated.")
      expect(page).to have_content("Complete")
    end
  end
  describe 'when deleting a list' do
    it 'redirects to index and shows deleted list message' do
      list = List.create(title: "Some Stuff")
      task = list.tasks.create(name: "a thing", due_date: "2019-03-03", complete: false)


      visit list_tasks_path(list)

      click_link 'Destroy'
      expect(page.current_path).to eq(list_tasks_path(list))

      expect(page).to have_content("Task a thing was successfully deleted.")

      expect(list.tasks.count).to eq(0)
    end
  end
end
