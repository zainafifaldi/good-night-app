class TestService < ApplicationService
  def self.single_data
    ::UserRepository.get_first_user
  end

  def self.multi_data
    ::UserRepository.find_all_users
  end
end
