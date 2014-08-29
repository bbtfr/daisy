module Hospitals
  class ExaminationsAPI < Grape::API
    extend ResourcesHelper

    namespace :examinations do
      index! Hospitals::Examination,
        title: "全国体检",
        filters: { 
          city: { default: 1, class: City, title: "位置" },
          examination_type: { class: Hospitals::ExaminationType, title: "体检类型" }
        }
    end
  end
end