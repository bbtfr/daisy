class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper

  mount AccountsAPI
  mount RelatedResourcesAPI
  mount FiltersAPI
  mount PriceSearchAPI

  mount UserInfos::FavoritesAPI
  mount UserInfos::PriceNotificationsAPI

  namespace :hospitals do
    mount Hospitals::HospitalsAPI
    mount Hospitals::DoctorsAPI
    mount Hospitals::TopSpecialistsAPI
    mount Hospitals::RegistrationsAPI
  end

  namespace :examinations do
    mount Examinations::ExaminationsAPI
  end

  namespace :eldercares do
    mount Eldercares::NursingRoomsAPI
  end

  namespace :drugs do
    mount Drugs::DrugsAPI
    mount Drugs::DrugstoresAPI
  end

  namespace :diseases do
    mount Diseases::DiseasesAPI
  end

  namespace :social_securities do
    mount SocialSecurities::SocialSecuritiesAPI
  end

  mount NetInfos::HotSearchKeywordsAPI

  get :config do
    AppConfig
  end

  route :any, '*path' do
    not_found!
  end

end
