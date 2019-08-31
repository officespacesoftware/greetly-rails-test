require 'spec_helper'

describe 'A user who visits the app' do
  # -------------------------------------
  it 'can create a task' do
    list_1 = List.create(title: "Dogs I want")

    
    visit list_path(list_1.id)
    expect(page).to have_content('Dogs I want')

    click_on "Tasks"
    expect(current_path).to eq(list_tasks_path(list_1.id))

    click_on "New Task"
    expect(current_path).to eq(new_list_task_path(list_1.id))

    fill_in :task_name, with: "Poodle"
    fill_in :task_due_date, with: "2022-12-25"

    click_on "Create Task"
    expect(current_path).to eq("/lists/#{list_1.id}/tasks/#{Task.last.id}")

    click_on "Back"
    expect(current_path).to eq(list_tasks_path(list_1.id))
    expect(page).to have_content("Poodle")
    expect(page).to have_content("2022-12-25")
  end
  # -------------------------------------
end

