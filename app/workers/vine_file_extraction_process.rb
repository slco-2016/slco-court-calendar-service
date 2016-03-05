require 'net/ftp'
require 'csv'

class VineFileExtractionProcess
  SLCO_FTP_HOST = ENV["SLCO_FTP_HOST"]
  SLCO_FTP_USER = ENV["SLCO_FTP_USER"]
  SLCO_FTP_PASSWORD = ENV["SLCO_FTP_PASSWORD"]

  def self.perform
    raise "CHECK CREDENTIALS" unless SLCO_FTP_HOST && SLCO_FTP_USER && SLCO_FTP_PASSWORD

    Net::FTP.open(SLCO_FTP_HOST, SLCO_FTP_USER, SLCO_FTP_PASSWORD) do |ftp|
      @ftp = ftp

      #
      # EXTRACT CASES
      #

      response = @ftp.get("/incoming/vine_case.ul", nil) # is there a way to not read this into memory?

      CSV.parse(response, csv_parse_options).each do |row|
        vine_case = VineCase.where({
          :locn_code => row["locn_code"],
          :case_num => row["case_num"]
        }).first_or_create!
        vine_case.update_attributes!({
          :court_type => row["court_type"],
          :first_name => row["first_name"],
          :last_name => row["last_name"],
          :party_num => row["party_num"],
          :disp_date => row["disp_date"],
          :disp_code => row["disp_code"],
          :bail_amt => row["bail_amt"],
          :birth_date => row["birth_date"],
          :race_code => row["race_code"],
          :gender => row["gender"],
          :disp_descr => row["disposition_descr"],
          :booking_num => row["booking_num"]
        })
      end

      #
      # EXTRACT CALENDAR EVENTS
      #

      # todo

    end
  end

  def self.csv_parse_options
    {
      :col_sep => "\t",
      :row_sep => "\r\r\n",
      :skip_blanks => true,
      :write_headers=> true,
      :headers => [
        "ca","locn_code","court_type","party_num",
        "case_num","first_name","last_name","disp_date",
        "disp_code","bail_amt","blank_field","birth_date",
        "race_code","gender","disposition_descr","booking_num"
      ]
    }
  end

  # @param [String] file A file name like "vine_court_event.ul"
  def self.read_contents(file)
    begin
      contents = @ftp.get(file, nil)
      puts " -- READING #{file}"
      return contents
    rescue Net::FTPPermError => e
      puts " -- FAILED TO OPEN #{file}" if e.message.include?("550 Failed to open file.")
    end
  end
end
