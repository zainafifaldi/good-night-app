Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :v1 do
    scope "sleep-records", controller: "sleep_record" do
      post "clock-in", action: "clock_in"
      post "wake-up", action: "wake_up"
    end

    scope "users/:user_id", controller: "user_follow" do
      post "follow", action: "follow"
      post "unfollow", action: "unfollow"
      get "following-sleep-records", action: "following_sleep_records"
    end

    get "test" => "test#index"
    get "test2" => "test#show"
  end
end
