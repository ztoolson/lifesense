class SensorSerializer < ActiveModel::Serializer
  attributes :id, :name, :formula

  has_one :pin_number
  has_many :records
  has_one :transmitter
end
