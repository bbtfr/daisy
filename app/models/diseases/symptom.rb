class Diseases::Symptom < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  def as_indexed_json(options={})
    as_json(only: ['name','name_initials'])
  end

  # has_and_belongs_to_many :diseases

  scope :query, -> (query) {
    if query.present? 
      search(
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match: {
                    name: query
                  }
                }
              ]
            }
          }
        }
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
