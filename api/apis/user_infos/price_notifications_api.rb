class UserInfos::PriceNotificationsAPI < Grape::API

  namespace :price_notifications do

    post :"(*:type_and_id)", anchor: false do
      match = env["PATH_INFO"].match(/(?<type>.*)\/(?<id>[^\/.?]+)/)
      klass = match[:type].classify.constantize
      record = current_user!.add_price_notification klass.find(match[:id]),
        params[:price]
      if record.save
        present :info, "成功添加降价通知"
      else
        failure! record
      end
    end
    
  end
end