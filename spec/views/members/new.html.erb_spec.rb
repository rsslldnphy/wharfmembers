require 'spec_helper'

describe "members/new" do
  before(:each) do
    assign(:member, stub_model(Member,
      :membership_number => 1,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => members_path, :method => "post" do
      assert_select "input#member_membership_number", :name => "member[membership_number]"
      assert_select "input#member_first_name", :name => "member[first_name]"
      assert_select "input#member_last_name", :name => "member[last_name]"
      assert_select "input#member_email", :name => "member[email]"
    end
  end
end
