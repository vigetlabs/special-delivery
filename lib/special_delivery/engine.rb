module SpecialDelivery
  class Engine < ::Rails::Engine
    isolate_namespace SpecialDelivery

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
