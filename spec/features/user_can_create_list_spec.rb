require 'spec_helper'

describe 'A user who visits the app' do
  # -------------------------------------
  it 'can create a list' do
    visit '/'

    click_on 'New List'
    expect(current_path).to eq(new_list_path)
  end
end

