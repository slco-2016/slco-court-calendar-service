require 'rails_helper'

RSpec.describe Api::V0::ApiController, type: :controller do
  describe "event_search" do
    context "when no search parameters are specified" do
      let(:response){
        rsp = get :event_search, {"format"=>"json"}
        JSON.parse(rsp.body)
      }

      it "should not return any events" do
        expect(response["results"]).to be_empty
      end
    end

    #context "when search parameters are specified" do
    #  let(:response){
    #    rsp = get :event_search, {"format"=>"json", "first_name"=> "KARL", "last_name"=>"MALONE", "birth_date"=>"____"}
    #    JSON.parse(rsp.body)
    #  }
#
    #  it "should return events matching the search parameters" do
    #    expect(response["results"]).to_not be_empty
    #  end
    #end

    # GET /api/v0/event-search.json
  end
end
