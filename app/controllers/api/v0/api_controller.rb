class Api::V0::ApiController < ApiController
  RECOGNIZED_SEARCH_PARAMETERS = ["api_key","first_name","last_name", "birth_date"]

  def index
    #code
  end

  # Search for one or more events. Results include events which match all conditions.
  #
  # @param [Hash] params
  # @param [Hash] params [String] api_key An unrevoked api key secret.
  # @param [Hash] params [String] first_name The defendant's first name.
  # @param [Hash] params [String] last_name The defendant's last name.
  # @param [Hash] params [String] birth_date The defendant date of burth in YYYY-MM-DD format.
  def event_search
    received_at = Time.zone.now
    errors = []
    results = [] # should default to empty
    search_params = params.reject{|k,v| ["controller","format","action"].include?(k) }

    api_key = params["api_key"] # ApiKey.find_by_secret(params["api_key"])
    first_name = params["first_name"].try(:upcase)
    last_name = params["last_name"].try(:upcase)
    birth_date = params["birth_date"] #todo: add error unless in "yyyy-mm-dd" format

    unrecognized_search_params = search_params.keys - RECOGNIZED_SEARCH_PARAMETERS
    unrecognized_search_params.each do |unrecognized_search_param|
      errors << UnrecognizedEventSearchParameter.new(unrecognized_search_param).message
    end

    #if api_key.is_a?(ApiKey) && api_key.unrevoked?
    if params["api_key"] == "my_key"
      results = VineCourtEvent.joins("JOIN vine_cases ON vine_cases.locn_code = vine_court_events.locn_code AND vine_cases.case_num = vine_court_events.case_num").select("vine_court_events.*, vine_cases.*") if first_name || last_name || birth_date
      results = results.where("UPPER(vine_court_events.first_name) LIKE ?", "%#{first_name}%") if first_name
      results = results.where("UPPER(vine_court_events.last_name) LIKE ?", "%#{last_name}%") if last_name
      results = results.where("vine_cases.birth_date = ?", birth_date) if birth_date
    elsif params["api_key"]
      errors << UnrecognizedApiKeyError.new(params["api_key"]).message
    else
      errors << MissingApiKeyError.new.message
    end

    results = results.any? ? results.map{|r|
      {
        "court_code": r.court_code,
        "court_type": r.court_type,
        "case_number": r.case_number,
        "party_number": r.party_number,
        "defendant_first_name": r.first_name.try(:strip),
        "defendant_last_name": r.last_name.try(:strip),
        "defendant_birth_date": r.birth_date,
        "appear_date": r.appear_date,
        "appear_time": r.time.try(:strftime, "%k:%M"),
        "hearing_code": r.hearing_code,
        "court_room": r.court_room
      }
    } : [] # should reset to empty array instead of nil value or activerecord object

    @response = {
      :request => {:url => request.url, :params => search_params, :received_at => received_at},
      :processed_at => Time.zone.now,
      :errors => errors,
      :results_count => results.count,
      :results => results
    }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end

  class UnrecognizedEventSearchParameter < ApiError
    def initialize(search_param)
      class_name = self.class.name.gsub("Api::V0::ApiController::","")
      msg = "#{class_name} -- '#{search_param}'"
      super(msg)
    end
  end
end
