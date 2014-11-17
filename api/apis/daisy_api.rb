class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper
  helpers FilterHelper

  mount HomeAPI
  mount AccountsAPI
  mount RelatedResourcesAPI
  mount SearchAPI

  mount MobileAPI

  mount UserInfos::FavoritesAPI
  mount UserInfos::PriceNotificationsAPI
  mount UserInfos::ReviewsAPI
  mount UserInfos::OrdersAPI

  namespace :categories do
    mount Categories::CitiesAPI
  end

  namespace :hospitals do
    mount Hospitals::HospitalsAPI
    mount Hospitals::DoctorsAPI
  end

  namespace :examinations do
    mount Examinations::ExaminationsAPI
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

  namespace :maternals do
    mount Maternals::MaternalHallsAPI
    mount Maternals::ConfinementCentersAPI
  end

  namespace :coupons do
    mount Coupons::CouponsAPI
  end

  namespace :social_securities do
    mount SocialSecurities::SocialSecuritiesAPI
  end

  namespace :eldercares do
    mount Eldercares::EldercaresAPI
  end

  namespace :insurances do
    mount Insurances::InsurancesAPI
  end

  mount NetInfos::HotSearchKeywordsAPI
  namespace :net_infos do
    mount NetInfos::HospitalTypeNewsAPI
    mount NetInfos::NetInfosAPI
  end
  

  route :any, '*path' do
    not_found!
  end

end
