module Drugs
  class DrugstoreEntity < Grape::Entity
    expose :id, :name, :image_url, :address

    expose :type do |object, options|
      "hospital"
    end

  end
end