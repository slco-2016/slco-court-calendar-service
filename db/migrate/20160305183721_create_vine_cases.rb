class CreateVineCases < ActiveRecord::Migration
  def change
    create_table :vine_cases do |t|
      t.string :locn_code, :null => false
      t.string :court_type
      t.string :case_num, :null => false
      t.string :first_name
      t.string :last_name #, :null => false
      t.integer :party_num #, :null => false

      t.string :disp_date
      t.string :disp_code
      t.string :bail_amt
      t.date :birth_date
      t.string :race_code
      t.string :gender
      t.string :disposition_descry
      t.string :booking_num

      t.timestamps null: false
    end

    add_index :vine_cases, :locn_code
    add_index :vine_cases, :case_num
    add_index :vine_cases, [:locn_code, :case_num], :unique => true, :name => :vine_case_composite_key
    add_index :vine_cases, :party_num
    add_index :vine_cases, :first_name
    add_index :vine_cases, :last_name
    add_index :vine_cases, :birth_date
  end
end
