class Diseases::Symptom < ActiveRecord::Base
  has_and_belongs_to_many :diseases

  scope :query, -> (query) {
    if query.present? 
      where("name_initials LIKE ? 
        or name LIKE ? ",
        "%#{query}%" ,
        "%#{query}%"
      ) 
    else
      all
    end
  }

  class << self
    include Filterable

    def filters
      self.all.group_by do |record|
        record.name_initials.first
      end.sort.map do |alphabet, records|
        Hash.new.tap do |ret|
          ret[:title] = alphabet
          ret[:children] = generate_filters records
        end
      end
    end

    define_cached_methods :filters
  end

end
