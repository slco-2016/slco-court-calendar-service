require 'net/ftp'
require 'csv'

class VineFileExtractionProcess
  SLCO_FTP_HOST = ENV["SLCO_FTP_HOST"]
  SLCO_FTP_USER = ENV["SLCO_FTP_USER"]
  SLCO_FTP_PASSWORD = ENV["SLCO_FTP_PASSWORD"]

  def self.perform
    raise "CHECK CREDENTIALS" unless SLCO_FTP_HOST && SLCO_FTP_USER && SLCO_FTP_PASSWORD

    VineCase.delete_all
    VineCourtEvent.delete_all

    Net::FTP.open(SLCO_FTP_HOST, SLCO_FTP_USER, SLCO_FTP_PASSWORD) do |ftp|
      @ftp = ftp
      @ftp.passive = true if Rails.env.production?

      #
      # EXTRACT CASES
      #

      puts " -- READING #{cases_file}"
      cases_response = @ftp.get(cases_file, nil)

      CSV.parse(cases_response, cases_csv_parse_options).each do |row|
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

      puts " -- READING #{events_file}"
      events_response = @ftp.get(events_file, nil)

      CSV.parse(events_response, events_csv_parse_options).each do |row|
        VineCourtEvent.where({
          :locn_code => row["locn_code"],
          :case_num => row["case_num"],

          :court_type => row["court_type"],
          :party_num => row["party_num"],
          :hearing_code => row["hearing_code"],
          :int_case_num => row["int_case_num"],

          :first_name => row["first_name"],
          :last_name => row["last_name"],

          :appear_date => row["appear_date"],
          :time => row["time"],
          :room => row["room"],

          :create_datetime => row["create_datetime"],
          :cancel_datetime => row["cancel_datetime"],
          :cancel_reason => row["cancel_reason"]
        }).first_or_create!
      end

      #
      # EXTRACT ALL THE THINGS
      #
    end
  end

  def self.cases_file
    "/incoming/vine_case.ul"
  end

  def self.events_file
    "/incoming/vine_court_event.ul"
  end

  def self.csv_parse_options
    {
      :col_sep => "\t",
      :row_sep => "\r\r\n",
      :skip_blanks => true
    }
  end

  def self.cases_csv_parse_options
    csv_parse_options.merge({
      :write_headers=> true,
      :headers => [
        "ca","locn_code","court_type","party_num",
        "case_num","first_name","last_name","disp_date",
        "disp_code","bail_amt","blank_field","birth_date",
        "race_code","gender","disposition_descr","booking_num"
      ]
    })
  end

  def self.events_csv_parse_options
    csv_parse_options.merge({
      :write_headers=> true,
      :headers => [
        "ce", "locn_code", "court_type","party_num",
        "case_num","first_name","last_name","appear_date",
        "time","hearing_code","room","int_case_num",
        "create_datetime","cancel_datetime","cancel_reason"
      ]
    })
  end
end
