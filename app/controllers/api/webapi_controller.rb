module Api
  class WebapiController < ApplicationController
    def query
      render json: {
          data: {
              "SYNO.AudioStation.Info" => {
                  "path" => "AudioStation/info.cgi",
                  "maxVersion" => 1
              }
          },
          sucess: true
      }
    end
  end
end