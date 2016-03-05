namespace :extract do
  desc "Extract VINE files"
  task :vine_files => :environment do
    VineFileExtractionProcess.perform
  end
end
