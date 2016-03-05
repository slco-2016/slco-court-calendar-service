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
      #opts = {:col_sep => "\t", :row_sep => "\r\r\n"}
      #rows = CSV.read("/incoming/vine_case.ul")
      #rows = CSV.read(response, 'r', col_sep: "\t")
      #puts rows.count
      #rows = CSV.read(response, csv_parse_options)
      #parsed_response = CSV.parse(response, csv_parse_options)

      #file = Rails.root.join("slco/vine/incoming/vine_charge.ul")
      #opts = {:col_sep => "\t", :row_sep => "\r\n"}
      #opts = {:col_sep => "\t", :row_sep => "\n", :encoding => "UTF-8"}
      #parsed_file = CSV.read(file, opts)
      #rows = response.split("CA").reject{|r| r.empty?}
      #rows.each do |row|
      #  vals = row.split("\t")
      #end

      binding.pry

      #rows = CSV.parse(response, csv_parse_options)
      CSV.parse(response, csv_parse_options).each do |row|
        puts row #> "\t2922\tJ\t2141370\t081800375\tKARL ANTHONY\tMALONE\t\t\t\t\\ \t12/02/1987\t\tM\t\t\t\r\r\n"
        #vine_case = VineCase.where({
        #  :locn_code => locn_code,
        #  :case_num => case_num
        #}).first_or_initialize!
        #vine_case.update_attributes!({
        #  :court_type => court_type,
        #  :first_name => first_name,
        #  :last_name => last_name,
        #  :party_num => party_num,
        #  :disp_date => disp_date,
        #  :disp_code => disp_code,
        #  :bail_amt => bail_amt,
        #  :birth_date => birth_date,
        #  :race_code => race_code,
        #  :gender => gender,
        #  :disposition_descr => disposition_descr,
        #  :booking_num => booking_num
        #})
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
      :headers => false,
      :skip_blanks => true
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
