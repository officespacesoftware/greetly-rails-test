require 'rails_helper'

describe "as a user" do
  describe "sorting by due date" do
    it "should show an arrow regard asc or desc" do
      list = List.create(title: "Some Stuff")
      task_1 = list.tasks.create(name: "a thing", due_date: "2019-03-03", complete: false)
      task_2 = list.tasks.create(name: "another thing", due_date: "2019-04-03", complete: true)

      visit list_tasks_path(list)

      click_link "Due Date↓"

      expect(page).to have_link("Due Date↑")
      click_link "Due Date↑"

      expect(page).to have_link("Due Date↓")
    end
  end
end
