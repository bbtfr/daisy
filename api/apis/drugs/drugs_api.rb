module Drugs
  class DrugsAPI < Grape::API
    extend ResourcesHelper
    extend FilterHelper

    namespace :drugs do 
      index! Drugs::Drug,
        title: "药品大全",
        filters: { 
          drug_type: { class: Drugs::DrugType, title: "药品类别" },
        }

      show! Drugs::Drug
    end

  end
end