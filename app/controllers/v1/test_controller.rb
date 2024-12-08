class V1::TestController < ApplicationController
  def index
    user = ::TestService.single_data

    render_json user, ::UserSerializer
  end

  def show
    users = ::TestService.multi_data

    render_json users, ::UserSerializer
  end
end
