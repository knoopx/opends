class Release < ActiveRecord::Base
  has_and_belongs_to_many :artists
  has_many :tracks, dependent: :destroy, order: arel_table[:number].asc

  validates_uniqueness_of :path
  before_create :process_release

  scope :recent, lambda { |limit| order(:created_at.desc).limit(limit) }

  scope :artist_name_eq, lambda { |name| joins(:artists).where(artists: {name: name}) }

  def process_release
    self.name = File.basename(self.path)

    artists = []
    albums = []
    years = []
    tracks = []

    Dir.glob(File.join(self.path, "*.mp3")) do |track_file|
      id3 = TagLib2::File.new(track_file)
      tracks << Track.new do |track|
        track.number = id3.track
        track.title = id3.title
        track.filename = File.basename(track_file)
        track.sample_rate = id3.sample_rate
        track.bitrate = id3.bitrate
        track.channels = id3.channels
        track.length = id3.length
        track.size = File.size(track_file)
        track.artist = Artist.find_or_create_by_normalized_name(id3.artist.to_slug.normalize.to_s, :name => id3.artist)
        years << track.year unless years.include?(track.year)
      end

      artists << id3.artist unless artists.include?(id3.artist)
      albums << id3.album unless albums.include?(id3.album)
    end

    # raise Exception.new("Found tracks from multile albums") unless albums.one?

    self.title = albums.first
    self.year = years.first
    self.various_artists = artists.size > 1
    self.tracks = tracks

    self.artists = artists.map do |artist_name|
      Artist.find_or_create_by_normalized_name(artist_name.to_slug.normalize.to_s, :name => artist_name)
    end

    true
  end
end