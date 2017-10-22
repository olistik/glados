resources :devices, only: [:create, :index]

namespace "devices" do
  post "/:device_name/heartbeats", to: "heartbeats#create"
end

root to: "home#index"
