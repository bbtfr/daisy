class Eldercares::NursingRoom < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"

  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }

  scope :null_last, -> (a) {
  	order("bed is null")
  }
  include Reviewable
  include JoinAppliable

end
