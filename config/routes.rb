class ActionConstraint
  def initialize(action)
    @action = action
  end

  def matches?(request)
    request.query_parameters['action'] == @action
  end
end

OpenDS::Application.routes.draw do
  match "/webapi/query.cgi" => 'api/webapi#query'
  match '/audio/iPhone/login.cgi' => "api/audio/ios#login"
  match '/audio/iPhone/enumerate.cgi' => "api/audio/ios#enumerate"
  match '/audio/iPhone/stream.cgi' => "api/audio/ios#stream"
  match '/audio/iPhone/transcoder.cgi' => "api/audio/ios#transcoder"
  match '/audio/iPhone/usb_controller.cgi' => "api/audio/ios#usb_controller"

  resources :releases
  resources :artists do
    resources :releases do
      resources :tracks
    end
  end

  root to: "releases#index"
end
