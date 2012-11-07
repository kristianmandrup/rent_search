shared_examples "a future period" do
  its(:start_date)  { should >= Date.today }
  its(:duration)    { should >= 1.day }
end