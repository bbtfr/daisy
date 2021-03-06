class Hospitals::HospitalOnsale < ActiveRecord::Base
  belongs_to :hospital_charge, class_name: "Hospitals::HospitalCharge"
  belongs_to :hospital, class_name: "Hospitals::Hospital"
  belongs_to :hall, class_name: "Hospitals::Hall", foreign_key: :hospital_id
  include Reviewable
  scope :extension, -> (flag) {
  	flag == 1 ? order(extension: :desc) : all
  }

  scope :hospital_type, -> (i) {
    charges_ids = Hospitals::HospitalType.where(id: i).first.hospital_charges.try(:ids) || []
    where(hospital_charge_id: charges_ids)
  }

  scope :hospital_charge, ->(i) {
  	where(hospital_charge_id: i)
  }
end