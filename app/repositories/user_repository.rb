class UserRepository < ApplicationRepository
  class << self
    def get_first_user
      ::User.first
    end

    def find_all_users
      ::User.all.to_a
    end
  end
end
