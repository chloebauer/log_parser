Rails.application.routes.draw do
  get "/logs", to: "log_viewer#logs"
end
