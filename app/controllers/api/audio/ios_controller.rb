require_dependency 'audio/ios/authentication'
require_dependency 'audio/ios/enumeration'
require_dependency 'audio/ios/streaming'

class Api::Audio::IosController < ApplicationController
  include Audio::Ios::Authentication
  include Audio::Ios::Enumeration
  include Audio::Ios::Streaming

  def usb_controller
    render json: {}
  end

  def handler
    @requested_action ||= request.get? ? request.query_parameters['action'] : request.request_parameters['action']
  end

  def respond_with_items(items)
    render json: {items: items, success: true, total: items.size}
  end
end
