SpecialDelivery::Engine.routes.draw do
  post "/" => "events#create", :as => "root"
end
