require 'spec_helper'

describe 'A user who visits the app' do
  # -------------------------------------
  it 'can create a list' do
    visit '/'

    click_on 'New List'
    expect(current_path).to eq(new_list_path)

    fill_in :list_title, with: "Big Financial Decisions"
    click_on "Create List"
    expect(current_path).to eq(list_path(List.last))
    expect(page).to have_content('Big Financial Decisions')
  end
  # -------------------------------------
end

