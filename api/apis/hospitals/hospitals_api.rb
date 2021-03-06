class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true 
      hospital.click!
    end
  end

  # namespace :registrations do
  #   index! Hospitals::Hospital,
  #     title: "手机挂号",
  #     filters: { 
  #       city: city_filters,
  #       type: type_filters(:hospital),
  #       hospital_type: { scope_only: true },
  #       county: county_filters,
  #       order_by: hospital_order_by_filters,
  #       form: form_filters,
  #       query: form_query_filters, 
  #       alphabet: form_alphabet_filters,
  #       hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
  #       has_url: form_switch_filters("网址"),
  #       is_local_hot: form_switch_filters("热门医院")
  #     }
  # end

  namespace :andrologies do
    index! Hospitals::Hospital,
      title: "男科医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("男科医院"),
        hospital_type: { scope_only: true },
        order_by_url: { scope_only: true, default: 1 },
        special: { scope_only: true },
        only_onsales: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
          # "当前主题精选"),
        template: form_radio_array_filters_new("andrology", "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }
  end

  namespace :plastics do
    index! Hospitals::Hospital,
      title: "整形医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("整形医院"),
        hospital_type: { scope_only: true },
        order_by_url: { scope_only: true, default: 2 },
        special: { scope_only: true},
        only_onsales: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 双眼皮（埋线法） 双眼皮（切开法） 内眼角 外眼角 上眼皮下垂 上下眼睑 眼睫毛皮肤切除 眼睫毛植毛 祛眼袋 内眦成形术 ),
          # "当前主题精选"),
        template: form_radio_array_filters_new("plastic", "当前主题精选"),
        price_scope: form_price_scope_filters([1000, 3000, 5000, 10000, 50000])
      }
  end

  namespace :tests do
    index! Hospitals::Hospital,
      title: "体检医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("体检医院"),
        # examination_type: { scope_only: true },
        # hospital_type: { scope_only: true, default: 3 },
        # order_by_url: { scope_only: true, default: 3 },
        # special: { scope_only: true },
        is_exam: {scope_only: true, default: 1},
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 基础体检 单位团体体检 常规体检 婚前体检 孕前体检 儿童体检 老年体检 妇科体检 青年体检 精英体检 高端体检),
          "当前主题精选"),
        price_scope: form_price_scope_filters([300, 600, 1000, 2000, 4000])
      },
      template: "hospitals/hospitals_t2"
  end
  # namespace :tests do
  #   index! Examinations::Examination,
  #     title: "体检医院",
  #     related: true,
  #     filters: { 
  #       city: city_filters,
  #       type: type_filters("体检医院"),
  #       # examination_type: { scope_only: true },
  #       # hospital_type: { scope_only: true, default: 3 },
  #       # order_by_url: { scope_only: true, default: 3 },
  #       # special: { scope_only: true },
  #       about_hostpitals: {scope_only: true},
  #       county: county_filters,
  #       order_by: hospital_order_by_filters,
  #       form: form_filters,
  #       # query: form_query_filters, 
  #       # alphabet: form_alphabet_filters,
  #       # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
  #       # has_url: form_switch_filters("网址"),
  #       # is_local_hot: form_switch_filters("热门医院")
  #       need_order: form_switch_filters("无需预约"),
  #       has_return: form_switch_filters("返现"),
  #       template: form_radio_array_filters(%w(不限 基础体检 单位团体体检 常规体检 婚前体检 孕前体检 儿童体检 老年体检 妇科体检 青年体检 精英体检 高端体检),
  #         "当前主题精选"),
  #       price_scope: form_price_scope_filters([300, 600, 1000, 2000, 4000])
  #     },
  #     template: "hospitals/hospitals_t2"
  # end

  namespace :tcm do
    index! Hospitals::Hospital,
      title: "中医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("中医院"),
        hospital_type: { scope_only: true}, #  default: 4 
        order_by_url: { scope_only: true, default: 4 },
        special: { scope_only: true },
        only_onsales: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        # order_by: order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 颈椎病推拿治疗 寰枢关节失稳推拿治疗 颈椎小关节紊乱推拿治疗 胸椎小关节紊乱推拿治疗 腰椎小关节紊乱推拿治疗 腰椎间盘突出推拿治疗 第三腰椎横突综合征推拿治疗 骶髂关节紊乱症推拿治疗 强直性脊柱炎推拿治疗 外伤性截瘫推拿治疗 退行性脊柱炎推拿治疗 ),
          # "当前主题精选"),
        template: form_radio_array_filters_new("tcm", "当前主题精选"),
        price_scope: form_price_scope_filters([10, 50, 100])
      },
      klass: proc { params[:is_hall]=="t" ? Hospitals::Hall : nil}
  end

  namespace :gynaecologies do
    index! Hospitals::Hospital,
      title: "妇幼医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("妇幼医院") ,
        hospital_type: { scope_only: true},
        order_by_url: { scope_only: true, default: 5 },
        special: { scope_only: true},
        only_onsales: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 剖腹产 卵巢囊切除术 子宫全切 子宫次全切 取环 放环 清宫 无痛清宫 引产术 子宫肌瘤剜除), 
          # "当前主题精选"),
        template: form_radio_array_filters_new("gynaecology", "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000])
      }
  end

  namespace :dentals do
    index! Hospitals::Hospital,
      title: "牙科医院",
      related: true,
      filters: { 
        city: city_filters,
        type: type_filters("牙科医院"),
        hospital_type: { scope_only: true, default: 6 },
        order_by_url: { scope_only: true, default: 6 },
        special: { scope_only: true},
        only_onsales: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 全瓷牙 镍铬烤瓷牙 钴铬合金烤瓷牙 钯银合金烤瓷牙 钯金合金烤瓷牙 钛合金烤瓷牙 E.MAX全瓷牙 美国"雷诺皓瓷牙"瑞典Procera皓瓷牙 德国泽康皓瓷牙),
          # "当前主题精选"),
        template: form_radio_array_filters_new("dental", "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }
  end

  namespace :polyclinics do
    index! Hospitals::Hospital,
      title: "综合医院",
      filters: { 
        extension: { scope_only: true, default: 1, type: Integer},
        city: city_filters,
        type: type_filters("综合医院"),
        hospital_type: { scope_only: true},
        hospital_level: { scope_only: true, default: false },
        # order_by_url: { scope_only: true, default: 7 },
        order_by_level: { scope_only: true, default: 7 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院"),
        is_foreign: { scope_only: true, type: Object },
        is_other: { scope_only: true, type: Object },
        is_community: { scope_only: true, type: Object },
        has_mobile_url: form_switch_filters("手机挂号"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(不限 医保定点医院 网上挂号/咨询 手机挂号/咨询 电话预约/咨询 字母),
          "当前主题精选")
      },
      template: "hospitals/hospitals_t1",
      includes: [:hospital_onsales, :hospital_types]
  end

  namespace :characteristics do
    index! Hospitals::Hospital,
      title: proc { Hospitals::Characteristic.find_by_id(params[:characteristic_hospitals]).try(:name) || "特色科室"},
      filters: { 
        extension: { scope_only: true, default: 1, type: Integer},
        city: city_filters,
        type: type_filters("特色科室"),
        # hospital_type: { scope_only: true, default: 7 },
        # hospital_level: { scope_only: true, default: false },
        # order_by_url: { scope_only: true, default: 7 },
        characteristic_hospitals: { scope_only: true, default: 1},
        # order_by_level: { scope_only: true, default: 7 },
        # county: county_filters,
        characteristic: { 
          title: proc { Hospitals::Characteristic.find_by_id(params[:characteristic_hospitals]).try(:name) || "特色科室"}, 
          children: proc { Hospitals::Characteristic.filters},
          key: "characteristic_hospitals"
        },
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院"),
        is_foreign: { scope_only: true, type: Object },
        is_other: { scope_only: true, type: Object },
        is_community: { scope_only: true, type: Object },
        has_mobile_url: form_switch_filters("手机挂号"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(不限 热门医院 有网址),
          "当前主题精选"),
        alphabet: form_alphabet_filters
      },
      template: "hospitals/hospitals_t1"
  end




  namespace :all do
    index! Hospitals::Hospital,
      title: "医院大全",
      filters: {
        city: city_filters,
        type: type_filters("医院大全"),
        # hospital_type: { scope_only: true, default: 7 },
        # hospital_level: { scope_only: true, default: false },
        # order_by_url: { scope_only: true, default: 7 },
        # characteristic_hospitals: { scope_only: true, default: 1},
        # order_by_level: { scope_only: true, default: 7 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        # query: form_query_filters, 
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院"),
        is_foreign: { scope_only: true, type: Object },
        is_other: { scope_only: true, type: Object },
        is_community: { scope_only: true, type: Object },
        has_mobile_url: form_switch_filters("手机挂号"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(不限 热门医院 有网址),
          "当前主题精选")
        # alphabet: form_alphabet_filters
      }
  end

  namespace :overseas do
    index! Hospitals::Hospital,
      title: "海外医院",
      filters: {
        extension: { scope_only: true, default: 1, type: Integer},
        province_oversease: { scope_only: true, type: Integer },
        type: type_filters("海外医院"),
        # province: oversea_city_filters,
        oversease: oversea_country_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        is_foreign: { scope_only: true, type: Object },
        is_other: { scope_only: true, type: Object },
        is_community: { scope_only: true, type: Object },
        # country: { scope_only: true, type: Integer },
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(内科 儿科 整形外科 脑神经外科 心脏血管外科 耳鼻咽喉科 皮肤科 癌症科 糖尿病与内分泌科 放射肿瘤科 肾病科 呼吸科 ),
          "当前主题精选")
      },
      parent: proc { Hospitals::Hospital.order_by_telephone.joins(city: :province).where("provinces.country_id" => 2)}
  end

end
