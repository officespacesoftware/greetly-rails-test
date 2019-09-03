require 'spec_helper'

describe Task do
  context "(empty)" do
    subject { Task.new }
    it "should not be valid" do
      expect(subject.valid?).to be_false
    end
  end

  context "due_date" do
    it "can add a due date" do
      list = List.create!(title: 'list1')
      task = Task.create!(name: 'task1', complete: false, list: list)

      due_date = Time.now + 3.days

      task.update_attributes(due_date: due_date)

      expect(task.due_date).to eq(due_date)
    end
  end
end
