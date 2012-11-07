shared_examples "an empty address" do
  its(:number)    { should be_nil }
  its(:street)    { should be_nil }
  its(:region)    { should be_nil }
  its(:city)      { should be_nil }
  its(:country)   { should be_nil }
  its(:zip_code)  { should be_nil }
end

shared_examples "a valid address" do
  its(:number)    { should_not be_nil }
  its(:street)    { should_not be_nil }
  its(:region)    { should_not be_nil }
  its(:city)      { should_not be_nil }
  its(:country)   { should_not be_nil }
  its(:zip_code)  { should_not be_nil }
end