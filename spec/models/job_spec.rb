describe "Job" do
  it "calculates running time of a job" do
    job = Job.first
    job.calculated_running_time.should_not be_nil if job
  end
end