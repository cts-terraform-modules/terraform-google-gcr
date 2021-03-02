control 'gcp-tests' do
  describe google_storage_bucket(name: attribute('output_gcr_bucket_name')) do
    it { should exist }
  end
end

control 'local-tests' do
  describe command("gcloud --project=#{attribute('input_project')} container images list") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should include 'Listed 0 items.' }
  end

  describe command("gsutil ls -p #{attribute('input_project')}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should == '' }
    its(:stdout) { should match "gs://#{attribute('output_gcr_bucket_name')}" }
  end
end
