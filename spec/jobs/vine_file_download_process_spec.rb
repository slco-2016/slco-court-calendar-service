require 'rails_helper'

RSpec.describe VineFileDownloadProcess, type: :job do
  let(:incoming_file_names){ [
    "cjs_judge.ul","login.txt","vine_case.ul",
    "vine_charge.ul","vine_court_event.ul","vine_delete.ul"
  ] }

  describe "perform" do
    it "should download 'incoming' vine files from the slco ftp server" do
      incoming_file_names.each do |file_name|
        file = Rails.root.join("slco/vine/incoming/#{file_name}")
        FileUtils.rm_rf(file)
      end

      VineFileDownloadProcess.perform

      incoming_file_names.each do |file_name|
        file = Rails.root.join("slco/vine/incoming/#{file_name}")
        expect(File.exist?(file))
      end
    end
  end
end
