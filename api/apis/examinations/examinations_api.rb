class Examinations::ExaminationsAPI < ApplicationAPI

  namespace :examinations do

    index! Examinations::Examination,
      title: "全国体检",
      filters: {
        city: fake_city_filters,
        type: type_filters("体检"),
        # examination_type: { scope_only: true },
        hospital: { scope_only: true },
        # county: fake_county_filters,
        order_by: order_by_filters(Examinations::Examination),
        form: form_filters,
        query: form_query_filters,
        price: form_price_filters,
        alphabet: form_alphabet_filters,
        hospital_query: form_radio_array_filters(
          %w(爱康国宾 美年大 慈铭体检 阳光体检), "品牌"),
        applicable_query: form_radio_array_filters(
          %w(男性 女性 白领 亚健康), "适应人群")
      }

    show! Examinations::Examination
    # get do
    #   examination_type_id = params[:examination_type_id]
    #   # type_id = params[:type] || 2
    #   if params[:examination_type_id].present?
    #     @examinations = Examinations::Examination.where(examination_type_id: examination_type_id).page(params[:page])
    #   else
    #     @examinations = Examinations::Examination.all.page(params[:page])
    #   end
    #   p @examinations
    #   @examinations.as_json(Examinations::Examination.demand_attrs)
    #   {
    #   title: "全国体检",
    #   filters: [
    #   {
    #       link: "types",
    #       key: "type",
    #       title: "全国体检",
    #       template: "list",
    #       current: "examination"
    #   },{
    #   title: "类别",
    #   children: Examinations::ExaminationType.where(parent_id: nil),
    #   template: "list",
    #   filter_only: true,
    #   current: 1,
    #   key: "type"
    #   },{
    #       "key" => "order_by",
    #       "title" => "智能排序",
    #       "template" => "list",
    #       "children" => [
    #           {
    #               "title" => "智能排序",
    #               "id" => "auto"
    #           },
    #           {
    #               "title" => "最新发布",
    #               "id" => "newest"
    #           }
    #       ],
    #       "current" => "auto"
    #   },
    #   {
    #       "template" => "form",
    #       "key" => "form",
    #       "title" => "筛选",
    #       "current" => nil,
    #       "children" => [

    #       ]
    #   }

    #   ],
    #   fin: true,
    #   data: @examinations.as_json(Examinations::Examination.demand_attrs)
    #   }
    # end
    # show! Examinations::Examination
  end



end
