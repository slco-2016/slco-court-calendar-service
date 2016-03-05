require 'net/ftp'
require 'pry'

SLCO_FTP_HOST = ENV["SLCO_FTP_HOST"]
SLCO_FTP_USER = ENV["SLCO_FTP_USER"]
SLCO_FTP_PASSWORD = ENV["SLCO_FTP_PASSWORD"]
raise "CHECK CREDENTIALS" unless SLCO_FTP_HOST && SLCO_FTP_USER && SLCO_FTP_PASSWORD

# @param [String] file A file name like "vine_court_event.ul"
def download(file, local_file)
  FileUtils.rm_rf(local_file)
  begin
    @ftp.get(file, local_file)
    puts " -- DOWNLOADED #{file} TO #{local_file}"
  rescue Net::FTPPermError => e
    puts " -- FAILED TO OPEN #{file}" if e.message.include?("550 Failed to open file.")
  end
end

#
# Connect to ftp server.
#

Net::FTP.open(SLCO_FTP_HOST, SLCO_FTP_USER, SLCO_FTP_PASSWORD) do |ftp|
  @ftp = ftp

  #
  # Download archived files.
  #

  @ftp.chdir('archive/vine')
  archive_files = @ftp.nlst("*")
  puts "FOUND #{archive_files.count} ARCHIVE FILES"
  archive_files.each do |file|
    local_file = "slco/vine/archive/#{file}"
    download(file, local_file)
  end

  #
  # Download incoming files
  #

  @ftp.chdir("/incoming")
  incoming_files = @ftp.nlst("*")
  incoming_files.reject!{|file| ["sbstnc_tst","vine"].include?(file) }
  puts "FOUND #{incoming_files.count} INCOMING FILES"
  incoming_files.each do |file|
    local_file = "slco/vine/incoming/#{file}"
    download(file, local_file)
  end
end
