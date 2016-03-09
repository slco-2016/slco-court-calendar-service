class ApiKeysController < ApplicationController
  before_action :authenticate_developer_account!

  def show
    @api_key = current_developer_account.current_api_key
    @request_urls = [
      "/api/v0/event-search.json?api_key=#{@api_key}",
      "/api/v0/event-search.json?api_key=#{@api_key}&first_name=KARL",
      "/api/v0/event-search.json?api_key=#{@api_key}&last_name=MALONE",
      "/api/v0/event-search.json?api_key=#{@api_key}&birth_date=1988-04-05",
      "/api/v0/event-search.json?api_key=#{@api_key}&first_name=KARL&last_name=MALONE&birth_date=1988-04-05",
    ]
  end

  def regenerate
    current_developer_account.regenerate_api_key!
    redirect_to root_path
  end
end
