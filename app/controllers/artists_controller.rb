class ArtistsController < InheritedResources::Base
  actions :all, except: [:new, :create]
end