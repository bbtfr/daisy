class Insurances::CommercialInsurance < ActiveRecord::Base
  
  scope :classification, -> (cf) {
  	cf ? where(classification: cf ) : all
  }
  class << self

  	def filters
  		select(:classification).distinct.map do |insurance|
  			Hash.new.tap do |ret|
	        ret[:id] = insurance.classification
	        ret[:title] = insurance.classification
	      end
  		end.unshift({id: nil, title: "全部"})

  	end
  end
end
