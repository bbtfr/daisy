class UserInfos::OrdersAPI < Grape::API

  namespace :orders do

    get do
      present! apply_scopes!(current_user!.orders.includes(:item)), 
        meta: { title: "我的订单" }
    end

    params do
      requires :order, type: Hash do
        optional :quantity, type: Integer
        optional :receive_name, type: String
        optional :receive_address, type: String
        optional :receive_zip, type: String
        optional :receive_mobile, type: String
      end
    end
    post :"(*:type_and_id)", anchor: false do
      match = env["PATH_INFO"].match(/(?<type>.*)\/(?<id>[^\/.?]+)/)
      klass = match[:type].classify.constantize
      record = current_user!.orders.new(declared(params)[:order])
      record.item = klass.find(match[:id])
      if record.save
        present :info, "成功创建订单，跳转支付页面"
        present :url, record.wap_pay_url
      else
        failure! record
      end
    end

  end
end
