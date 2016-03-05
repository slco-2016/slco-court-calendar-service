require 'rails_helper'

RSpec.describe VineFileExtractionProcess, type: :job do
  describe "#perform" do
    #let(:line_string){
    #  "\t2922\tJ\t2141370\t081800375\tKARL ANTHONY\tMALONE\t\t\t\t\\ \t12/02/1987\t\tM\t\t\t\r\r\n"
    #} # results of splitting the string on "CA"
    #let(:split_string){
    #  ["", "2922", "J", "2141370", "081800375", "ANDREW MICHAEL", "LOPEZ", "", "", "", "\\ ", "12/02/1987", "", "M", "", "", "\r\r\n"]
    #} # results of line_string.split("\t")

    let(:response){
      "CA\t2922\tJ\t2141370\t081800375\tKARL ANTHONY\tMALONE\t\t\t\t\\ \t12/02/1987\t\tM\t\t\t\r\r\nCA\t2922\tJ\t2144096\t081800621\tJOHN\tSTOCKTON\t\t\t\t\\ \t12/02/1987\t\t\t\t\t\r\r\n"
    }

    let(:csv_parse_options){
      {
        :col_sep => "\t",
        :row_sep => "\r\r\n",
        :headers => false,
        :skip_blanks => true
      }
    }
    let(:parsed_row){
      ["CA", "2922", "J", "2141370", "081800375", "KARL ANTHONY", "MALONE", nil, nil, nil, "\\ ", "12/02/1987", nil, "M", nil, nil, nil]
    }

    it "should parse tab-delimited data" do
      parsed_response = CSV.parse(response, csv_parse_options)
      expect(parsed_response.include?(parsed_row))
    end

    #it "should persist case data from 'incoming' vine files" do
    #  VineCase.delete_all
    #  VineFileExtractionProcess.perform
    #  expect(VineCase.count).to be > 0
    #end
  end
end
