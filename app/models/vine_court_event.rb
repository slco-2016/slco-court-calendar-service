class VineCourtEvent < ActiveRecord::Base
  #belongs_to :vine_case, :inverse_of => :vine_court_events

  def vine_case
    VineCase.where("vine_cases.locn_code = ? AND vine_cases.case_num = ?", locn_code, case_num).first
  end

  def court_code
    locn_code
  end

  def case_number
    case_num
  end

  def party_number
    party_num
  end

  def birth_date
    vine_case.birth_date
  end

  def appear_time
    time
  end

  def court_room
    room
  end

  #def search_result
  #  {
  #    "court_code": court_code,
  #    "court_type": court_type,
  #    "case_number": case_number,
  #    "party_number": party_number,
  #    "defendant_first_name": first_name,
  #    "defendant_last_name": last_name,
  #    "defendant_birth_date": birth_date,
  #    "appear_date": appear_date,
  #    "appear_time": appear_time,
  #    "hearing_code": hearing_code,
  #    "court_room": court_room
  #  }
  #end
end
