module Hospitals
  class DoctorsAPI < Grape::API
    extend ResourcesHelper

    resources :doctors, 
      class: Hospitals::Doctor,
      title: "找医生",
      filters: { 
        hospital: { class: Hospitals::Hospital, title: "医院" },
        hospital_room: { class: Hospitals::HospitalRoom, title: "医院科室" }
      }

  end
end