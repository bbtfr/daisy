module FilterHelper
  extend ActiveSupport::Concern

  def parse_option_value *args
    value = args.pop
    if value.kind_of? Proc
      instance_exec *args, &value
    elsif value
      value
    elsif block_given?
      yield *args
    end
  end

  def generate_filter key, options
    parse_option_value options[:before]
    filter = options[:meta] ? options[:meta].dup : {}
    filter[:key] ||= parse_option_value options[:key] { key }
    filter[:title] ||= parse_option_value key, options[:title] 
    filter[:template] ||= parse_option_value options[:template] { :list }
    filter[:children] ||= parse_option_value key, options[:children] do
      options[:class].filters
    end if options[:class] || options[:children]
    filter[:current] = parse_option_value key, options[:current] do
      params[key] || options[:default]
    end
    filter
  end

  def append_url_to_filters array, url
    array.each do |hash|
      hash[:url] = url if hash[:params]
      append_url_to_filters hash[:children], url if hash[:children]
    end
  end

  module ClassMethods

    def oversea_city_filters
      {
        meta: {
          keep: :city,
          link: :"categories/cities"
        },
        default: 2,
        title: "位置",
        titleize: true,
      }
    end

    def oversea_country_filters
      {
        title: proc {Categories::Province.where(country_id: 2, id: params[:province]).first.try(:name) || "全部"},
        key: "province_oversease",
        template: "list",
        children: proc { Categories::Province.overses_filters(params[:country]) },
      }
    end


    def city_filters
      {
        meta: {
          keep: :city,
          link: :"categories/cities"
        },
        # default: 2,
        title: "位置",
        titleize: true,
      }
    end

    def fake_city_filters
      {
        meta: {
          keep: :city,
          link: :"categories/cities"
        },
        default: 1,
        class: Categories::City,
        title: "位置",
        titleize: true,
        filter_only: true
      }
    end

    def county_filters
      { 
        title: proc {Categories::County.find_by_id(params[:county]).try(:name) || "全城" },
        children: proc { Categories::County.filters(params[:city]) },
      }
    end

    def fake_county_filters
      { 
        title: proc {Categories::County.find_by_id(params[:county]).try(:name)  || "全城" },
        children: proc { Categories::County.filters(params[:city]) },
        filter_only: true
      }
    end

    def examination_parent_type
      { 
        title: proc { Examinations::ExaminationType.where(id: params[:type]).first.try(:name) || "类别" } ,
        key: "type",
        children: proc { 
          Examinations::ExaminationType.where(parent_id: nil).map do |type|
            {id: type.id,
             title: type.name,
             url: "#/list/examinations/examination_type?type=#{type.id}"
           }

          end
         },
         current: proc { params[:examination_type]}
        # filter_only: true
      }
    end
 
    def hospital_charge_type
      {
        title: proc {Hospitals::HospitalType.where(id: params[:hospital_type]).first.try(:name) || "类别" } ,
        key: "type",
        children: proc {
          Hospitals::HospitalType.where(parent_id: params[:hospital_parent_type]).map do |type|
            {
              id: type.id,
              title: type.name,
              url: "#/list/hospitals/hospital_charges?hospital_parent_type=#{type.parent_id}&hospital_type=#{type.id}"
            }
          end
        },
        current: proc{ params[:hospital_parent_type] },
        # hospital_parent_type: "proc { params[:hospital_parent_type] }
        # "
      }
    end

    def price_filters
      { 
        type: Hash,
        using: [:to, :from],
        scope_only: true
      }
    end

    def form_price_filters
      { 
        meta: { 
          key: :price,
          title: "价格区间", 
          template: :price,
        },
        type: Hash,
        using: [:to, :from],
        append: :form 
      }
    end

    def form_price_scope_filters array
      { 
        meta: { 
          key: :price_scope,
          title: "价格区间", 
          template: :radio,
        },
        type: String,
        children: proc do
          children = []
          children.push title: "不限", id: "-"
          children.push title: "#{array.first-1}元 以下", id: "0-#{array.first}"
          array.each_cons(2) do |from, to|
            children.push title: "#{from}元 至 #{to}元", id: "#{from}-#{to}"
          end
          children.push title: "#{array.last}元 以上", id: "#{array.last}-"
          children
        end,
        append: :form 
      }
    end

    def form_filters
      {
        meta: { 
          template: :form,
        },
        title: "筛选",
        filter_only: true
      }
    end

    def form_radio_filters klass, title
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        children: proc { klass.form_filters },
        append: :form 
      }
    end

    def form_radio_array_filters array, title
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        type: String,
        children: proc do 
          array.each_with_index.map do |title, index| 
            { title: title, id: index }
          end
        end,
        append: :form 
      }
    end

    def form_radio_array_filters_new type, title
      
      h = FilterOfHospital[type]
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        type: String,
        children: proc do 
          id = params[:hospital_type]
          array = h[id] || h[0]
          p array
          array.each_with_index.map do |title, index| 
            { title: title, id: index }
          end
        end,
        append: :form 
      }

    end

    def form_query_filters title = "搜索"
      {
        meta: { 
          title: title, 
          template: :string,
        },
        type: String,
        append: :form,
      }
    end

    def alphabet_filters
      {
        title: "字母",
        children: ('A'..'Z').map do |s| 
          { title: s, id: s }
        end
      }
    end

    def form_alphabet_filters
      {
        meta: { 
          key: :alphabet,
          title: "字母搜索", 
          template: :alphabet,
        },
        type: String,
        append: :form
      }
    end

    def form_switch_filters title
      {
        meta: { 
          title: title,
          template: :switch,
        },
        type: Object,
        current: proc { |key| params[key] == "true" },
        append: :form
      }
    end

    def type_filters title="全部类别", current=nil 
      {
        meta: {
          link: :types
        },
        type: String,
        title: title,
        filter_only: true,
        current: proc { current || params[:type]}
      }
    end

    def search_by_filters options
      {
        type: Symbol,
        filter_only: true,
        default: options[:default],
        key: proc { params[:search_by] || options[:default] },
        before: proc do
          search_by_key = params[:search_by]
          search_by_options = options[search_by_key]
          has_scope search_by_key unless search_by_options[:filter_only]
        end,
        title: proc do
          search_by_options = options[params[:search_by]]
          parse_option_value search_by_options[:title] 
          # search_by_options[:title]
        end,
        children: proc do
          search_by_options = options[params[:search_by]]
          # if method = search_by_options[:method]
          #   search_by_options[:class].try(method, params[params[:search_by]])
          # else
            if search_by_options[:children]
              parse_option_value search_by_options[:children]
            else
              parse_option_value do
                search_by_options[:class].filters
              end
            
            end
          # end
        end,
        current: proc do
          options[:current] || params[params[:search_by]]
        end
      }
    end

    def order_by_filters klass, options = {}

      filters_list = {
        newest: "最新发布",
        hotest: "人气最高",
        favoriest: "评价最好",
        cheapest: "价格最低",
        most_expensive: "价格最高",
        nearest: "离我最近"
      }
      {
        default: options[:default] || :auto,
        type: String,
        title: proc { filters_list[params[:order_by].try(:to_sym)] ||"智能排序"},
        children: proc do
          filters = []
          filters << { title: "智能排序" , id: :auto }
          if klass < Localizable && params[:location]
            filters << { title: "离我最近" , id: :nearest }
          end
          # if klass < Reviewable
          #   filters << { title: "评价最好" , id: :favoriest }
          #   filters << { title: "人气最高" , id: :hotest }
          # end
          # filters << { title: "最新发布" , id: :newest }
          # if klass.attribute_names.include? "sale_price"
          #   filters << { title: "价格最低" , id: :cheapest }
          #   filters << { title: "价格最高" , id: :most_expensive }
          # end

          filters += [
            # { title: "离我最近", id: :nearest},
            { title: "最新发布", id: :newest},
            { title: "人气最高", id: :hotest},
            { title: "评价最好", id: :favoriest},
            { title: "价格最低", id: :cheapest},
            { title: "价格最高", id: :most_expensive}
          ]
          # parse_option_value filters, options[:children]
          filters
        end,
        has_scope: proc do |endpoint, collection, key|
          case key.to_sym
          when :auto
            collection
          when :nearest
            params = endpoint.params
            lat = params[:location][:lat]
            lng = params[:location][:lng]
            collection.nearest(lat, lng)
          when :favoriest
            collection.order(star: :desc)
          when :hotest
            # collection.order(reviews_count: :desc)
            collection.order(click_count: :desc)
          when :newest
            collection.order(created_at: :desc)
          when :cheapest
            collection.order(ori_price: :asc)
          when :most_expensive
            collection.order(ori_price: :desc)
          else
            if options[:has_scope]
              instance_exec endpoint, collection, key, &options[:has_scope]
            else
              collection
            end
          end
        end
      }
    end

    def hospital_order_by_filters
      order_by_filters Hospitals::Hospital, {
        default: :hospital_level,
        children: proc do |filters|
          filters.insert(1, { title: "医院等级" , id: :hospital_level })
        end,
        has_scope: proc do |endpoint, collection, key|
          if key.to_sym == :hospital_level
            collection.hospital_level
          else
            collection
          end
        end
      }
    end

    def hospital_onsale_order_by_filters
      order_by_filters Hospitals::HospitalOnsale, {
        children: proc do |filters|
          filters.insert(1, { title: "医院等级" , id: :hospital_level })
        end,
        has_scope: proc do |endpoint, collection, key|
          if key.to_sym == :hospital_level
            collection.hospital_level
          else
            collection
          end
        end
      }
    end

    def common_disease_filters
      {
        title: proc do
          Diseases::CommonDisease.all.where(id: params[:common_disease]).first.try(:name) || Diseases::Disease.where(id: params[:id]).first.try(:name) || "全部" 
        end,
        key: "common_disease",
        template: "list",
        children: proc do
          Diseases::CommonDisease.all.map do |common_disease|
            { 
              title: common_disease.name, 
              id: common_disease.id,
              children: Diseases::Disease.common_disease(common_disease.id).map do |disease|
                  {
                    # url: "#/detail/diseases/diseases/#{disease.id}",
                    title: disease.name,
                    id: disease.id,
                    params: { disease_id: disease.id, common_disease: common_disease.id }
                  }
              end
            }
          end
        end,
        current: proc { params[:disease_id] },
        # class: :common_disease
      }
    end

    def common_examination_filters
      {
        title: proc do
          Examinations::ExaminationType.where(id: params[:examination_type_id]).first.try(:name) || "全部" 
          # Examinations::Examination.all.where(id: params[:common_disease]).first.try(:name) || Examinations::Examination.where(id: params[:id]).first.try(:name) || "全部" 
        end,
        key: "common_examination",
        template: "list",
        children: [{
          id: :examination,
          title: "全部",
          filterTitle: "全国体检"
        }, {
          title: "热门体检",
          children: Examinations::ExaminationType.where(parent_id: 1).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          #params: { examination_parent_type: 1 }
        }, {
          title: "体检机构",
          params: { examination_parent_type: 1 }
        }, {
          title: "商务体检套餐",
          children: Examinations::ExaminationType.where(parent_id: 74).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 74 }
        }, {
          title: "肿瘤检测",
          children: Examinations::ExaminationType.where(parent_id: 65).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            } 
          end
          # params: { examination_parent_type: 65 }
        }, {
          title: "高发疾病检测",
          children: Examinations::ExaminationType.where(parent_id: 93).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 93 }
        }, {
          title: "适用人群套餐",
          children: Examinations::ExaminationType.where(parent_id: 22).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 22 }
        }, {
          type: "hospitals/hospital_news",
          title: "体检诊疗攻略",
          params: { hospital_type: 3 }
        }, {
          type: "examinations/examinations",
          title: "体检价格攻略"
        }],
        current: proc { params[:disease_id] },
        # class: :common_disease
      }
    end

    # {
    #   type: "examinations/examinations",
    #   title: "全国体检",
    # #  count: Examinations::Examinatio#n.count,
    #   children: []
    # }


    def hospital_type_filters
      {
        title: proc do
           Hospitals::HospitalType.find_by_id(params[:hospital_type]).try(:name) || "全部"
        end,
        key: "hospital_type",
        template: "list",
        children: proc do
          Hospitals::HospitalType.where(parent_id: nil).map do |hospital_type|
            {
              image_url:hospital_type.image_url, 
              title: hospital_type.name, 
              children: Hospitals::HospitalType.filters(hospital_type.hospital_types)
            }
          end
        end,
        # current: proc { params[:hospital_type]},
        class: :hospital_type
      }
    end

    def classification_filters
      {
        title: proc do 
          params[:classification] || "全部"
        end,
        key: "classification",
        template: "list",
        children: Insurances::CommercialInsurance.filters,
        type: String
      }
    end

    def hospital_charge_filters(type)
      url = case type
            when "newest"
              "#/privileges/newest"
            when "hospitals"
              "#/privileges/hospitals"
            end
      {
        title: proc do 
          Hospitals::HospitalCharge.where(id: params[:hospital_charge]).first.try(:name) || "全部"
        end,
        key: "hospital_charge",
        template: "list",
        children: proc do 
          Hospitals::HospitalType.where(parent_id: nil, filter: true).map do |hospital_type|
            all = {
              title: "全部",
              url: "#{url}?hospital_type=#{hospital_type.id}"
            }
            {
              image_url:hospital_type.image_url, 
              title: hospital_type.name, 
              children: hospital_type.hospital_types.map do |ht|
                {
                  title: ht.name,
                  children: Hospitals::HospitalCharge.filters(ht.hospital_charges).each do |filter|
                    if filter[:title] == "全部" 
                      filter.merge!({title:"全部", url: "#{url}?hospital_type=#{ht.id}"})
                    end
                  end
                }
              end.unshift(all)
            }
          end
        end

      }
    end

    def drug_type_filters
      {
        key: "drug_type",
        title: "类别",
        template: "list",
        children:  proc do
          Drugs::DrugType.where(parent_id: nil).map do |drug_type|
            if drug_type.name == "常见疾病"
              {
                id: drug_type.id,
                title: drug_type.name,
                children: Diseases::CommonDisease.all.map do |common_disease|
                  {
                    id: common_disease.id,
                    title: common_disease.name,
                    children: common_disease.diseases.map do |disease|
                      {
                        id: disease.id,
                        title: disease.name
                      }
                    end

                    }
                end
              }
            else
            {
              id:  drug_type.id,
              title: drug_type.name,
              children: drug_type.children.map do |drug_type_child|
                {
                  id: drug_type_child.disease_id,
                  title: drug_type_child.name,
                  children: drug_type_child.children.map do |drug_type_child_child|
                    {
                      id: drug_type_child_child.disease_id,
                      title: drug_type_child_child.name
                    } 
                  end 
                } 
              end
            }
            end
          end.unshift(
          {
            title: "全部",
            parent: true,
            id: nil
            }
          )
        end

      }
      
    end

  end
end
