module Drugs
  class DrugEntity < ApplicationEntity
    expose :id, :name, :image_url, :ori_price, :sale_price

  end
end