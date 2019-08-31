require 'spec_helper'

describe Task do
  context "(empty)" do
    subject { Task.new }
    it "should not be valid" do
      expect(subject.valid?).to be_false
    end
  end

  context 'attributes' do
    future_date = Time.parse("2030-04-01")
    list_1 = List.create(title: "Big Financial Decisions")
    task_1 = Task.create(name: "Purchase a Kia Telluride", complete: false, due_date: future_date)
    task_1.list_id = 1
    
    it 'should have a due_date' do
      expect(task_1.due_date).to eq(future_date)
    end

  end
end
