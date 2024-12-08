class SerializerAdapter < ActiveModelSerializers::Adapter::Base
  def serializable_hash(options = nil)
    {
      "data" => ActiveModelSerializers::Adapter::Attributes.new(serializer).serializable_hash
    }
  end
end
