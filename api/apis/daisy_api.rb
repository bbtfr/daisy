class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper

  mount HomeAPI
  mount AccountsAPI
  mount RelatedResourcesAPI
  mount PriceSearchAPI
  mount CouponsAPI

  mount UserInfos::FavoritesAPI
  mount UserInfos::PriceNotificationsAPI
  mount UserInfos::ReviewsAPI
  mount UserInfos::OrdersAPI

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

  namespace :shapings do
    mount Shapings::ShapingItemsAPI
  end

  mount SocialSecuritiesAPI

  namespace :maternals do
    mount Maternals::MaternalHallsAPI
    mount Maternals::ConfinementCentersAPI
  end

  mount NetInfos::HotSearchKeywordsAPI

  route :any, '*path' do
    not_found!
  end

end
