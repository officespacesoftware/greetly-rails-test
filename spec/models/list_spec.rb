require 'rails_helper'

describe List do
  context "(empty)" do
    subject { List.new }
    it "should not be valid" do
      expect(subject.valid?).to be(false)
    end
  end
end
