class Artist < ActiveRecord::Base
  has_and_belongs_to_many :releases, order: arel_table[:year].desc
  has_many :tracks
  has_and_belongs_to_many :genres, uniq: true

  scope :with_more_than_one_track, -> { where(Artist.arel_table[:tracks_count].gt(1)) }
  scope :recent, lambda { |limit| order(:created_at.desc).limit(limit) }
  scope :genres_id_in, lambda { |genres| joins(:taggings).where(:taggings => {:genre_id => genres}) }
  scope :genres_id_not_in, lambda { |genres| joins(:taggings).where(:taggings => {:genre_id.not_in => genres}) }

  validates_presence_of :normalized_name, :name
  validates_uniqueness_of :name

  before_save :normalize_name

  def normalize_name
    self.normalized_name = self.name.to_slug.normalize.to_s
  end
end
