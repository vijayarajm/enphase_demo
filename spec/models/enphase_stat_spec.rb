describe "EnphaseStat" do
  it "checks for valid_data_on_creation" do
    stat = EnphaseStat.first
    stat.valid_data_on_creation.should_not be_nil if stat
  end
end