class VineCase < ActiveRecord::Base
  #has_many :vine_court_events, :inverse_of => :vine_case

  def vine_court_events
    VineCourtEvent.where("vine_court_events.locn_code = ? AND vine_court_events.case_num = ?", locn_code, case_num)
  end
end
