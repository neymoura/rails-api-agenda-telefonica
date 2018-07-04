class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :picture, :birth

  def birth
    object.birth.to_time.to_i
  end

end
