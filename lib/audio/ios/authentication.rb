module Audio
  module Ios
    module Authentication
      # GET http://(null)(null)/iPhone/login.cgi?action=logout

      # TODO: Bad login response?
      # http://demosite.synology.me:5000/webman/3rdparty/AudioStation/iPhone/login.cgi
      def login
        render json: {
            :build => "2636",
            :major => "4",
            :minor => "1",
            :playlist => true,
            :reason => "success",
            :result => "success",
            :serialNumber => "BCKJN00104",
            :speaker => false,
            :stream => true,
            :transcode_capability => ["mp3"],
            :usb => false
        }
        #render json: {reason: "error_cantlogin", result: "error"}
      end
    end
  end
end