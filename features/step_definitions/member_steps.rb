Given /^I am on the new member page$/ do
  within "#menu-members" do
    click_on 'New Member'
  end
end

When /^I register a new member$/ do
  fill_in  'First name',    with: 'Russell'
  fill_in  'Last name',     with: 'Dunphy'
  fill_in  'Email',         with: 'russell@russelldunphy.com'
  fill_in  'Postcode',      with: 'PC12 34'
  uncheck  'Email allowed'
  click_on 'Create Member'
end

Then /^They appear on the pending registrations page/ do
  within "#menu-members" do
    click_on 'Pending'
  end
  page.should have_content 'Russell Dunphy'
end

But /^They do not appear on the current members page/ do
  within "#menu-members" do
    click_on 'Current'
  end
  page.should_not have_content 'Russell Dunphy'
end

And /^They do not appear on the mailing list page/ do
  within "#menu-members" do
    click_on 'Mailing List'
  end
  page.should_not have_content 'Russell Dunphy'
end

Given /^I registered a new member over 48 hours ago$/ do
  @member = Member.new(first_name: 'Russell', last_name: 'Dunphy')
  @member.register
  @member.membership.value.start = Time.now
  @member.save
end

Then /^They appear on the current members page$/ do
  within "#menu-members" do
    click_on 'Current'
  end
  page.should have_content 'Russell Dunphy'
end

And /^They do not appear on the pending registrations page$/ do
  within "#menu-members" do
    click_on 'Pending'
  end
  page.should_not have_content 'Russell Dunphy'
end

And /^They do not appear on the expired members page$/ do
  within "#menu-members" do
    click_on 'Expired'
  end
  page.should_not have_content 'Russell Dunphy'
end

And /^They appear on the mailing list page$/ do
  within "#menu-members" do
    click_on 'Mailing List'
  end
  page.should have_content 'Russell Dunphy'
end

Given /^I registered a member over a year ago$/ do
  @member = Member.new(first_name: 'Russell', last_name: 'Dunphy')
  @member.register
  @member.membership.each do |membership|
    membership.year  = membership.year - 1
    membership.start = membership.start - 1.year
  end
  @member.save
end

When /^I renew their membership$/ do
  within "#menu-members" do
    click_on 'Expired'
  end
  check "member_#{@member.id}"
  click_on "Renew Selected"
end

Then /^They appear on the expired members page$/ do
  within "#menu-members" do
    click_on 'Expired'
  end
  page.should have_content 'Russell Dunphy'
end
