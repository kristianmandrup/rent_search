shared_examples "a new property" do
  its(:photos)      { should be_empty }
  its(:rent_period) { should be_nil }
end