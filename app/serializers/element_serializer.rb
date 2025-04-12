class ElementSerializer < ActiveModel::Serializer
  attributes :id, :element_type, :fader_value, :button_status

  def fader_value
    object.fader&.value
  end
end
