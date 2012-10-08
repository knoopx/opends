class Track < ActiveRecord::Base
  belongs_to :release, :counter_cache => true
  belongs_to :artist, :counter_cache => true

  scope :artist_name_eq, lambda { |name| joins(:artist).where(artists: {name: name}) }
  scope :release_title_eq, lambda { |name| joins(:release).where(releases: {title: name}) }
end
