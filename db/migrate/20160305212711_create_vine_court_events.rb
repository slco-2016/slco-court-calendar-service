class CreateVineCourtEvents < ActiveRecord::Migration
  def change
    create_table :vine_court_events do |t|
      t.string :locn_code
      t.string :case_num

      t.string :court_type
      t.integer :party_num
      t.string :hearing_code
      t.integer :int_case_num

      t.string :first_name
      t.string :last_name
      t.date :appear_date
      t.time :time
      t.string :room

      t.datetime :create_datetime
      t.datetime :cancel_datetime
      t.string :cancel_reason

      t.timestamps null: false
    end

    add_index :vine_court_events, :locn_code
    add_index :vine_court_events, :case_num
    add_index :vine_court_events, [:locn_code, :case_num], :name => :event_case_foreign_composite_key
    add_index :vine_court_events, :appear_date
    add_index :vine_court_events, :room
  end
end
