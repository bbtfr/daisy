class Hospitals::HospitalFilterEntity < Grape::Entity

  expose :name, as: :title

  expose :params do |object, options|
    { hospital: object.id }
  end

end
