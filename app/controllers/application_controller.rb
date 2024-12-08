class ApplicationController < ActionController::API
  def render_json(data, serializer)
    serializer_key = data.is_a?(Array) ? :each_serializer : :serializer

    options = {
      serializer_key => serializer,
      :json          => data,
      :adapter       => ::SerializerAdapter
    }
    render options
  end
end
