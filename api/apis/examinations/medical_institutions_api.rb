class Examinations::MedicalInstitutionsAPI < ApplicationAPI

	namespace :medical_institutions do
     index! Hospitals::Hospital,
      title: "体检医院",
      filters: { 
        type: type_filters("体检机构", :medical_institution),
        county: fake_county_filters,
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
  end

end