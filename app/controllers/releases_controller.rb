require 'iconv'

class ReleasesController < ApplicationController
  inherit_resources

  self.paginate = true
end