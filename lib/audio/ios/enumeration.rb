module Audio
  module Ios
    module Enumeration
      HANDLERS = %w(get_lyrics get_cover get_cover_for_album all_playlist_enum playlist_song_enum artist_enum album_enum song_enum search genre_enum folder_enum radio_enum)

      def enumerate
        if HANDLERS.include?(handler)
          send(handler)
        else
          render nothing: true, code: 404
        end
      end

      ##################################################################################################################
      # GET
      ##################################################################################################################

      def get_lyrics
        # TODO
        render nothing: true, code: 404
      end

      def get_cover
        # TODO
        #track = Track.find(params[:music_id])
        #if file = Dir.glob(File.join(track.release, '*.jpg')).first
        #  send_file file
        #end
        render nothing: true, code: 404
      end

      ##################################################################################################################
      # POST
      ##################################################################################################################

      def get_cover_for_album
        # TODO
        #{"album_name"=>"Self Titled", "artist_name"=>"100 Demons", "library"=>"all"}
        #puts "FETCHING" * 20
        #response = Nestful.get("http://ws.audioscrobbler.com/2.0/", :format => :json, :params => {
        #    :api_key => "b25b959554ed76058ac220b7b2e0a026",
        #    :format => "json",
        #    :method => "album.getinfo",
        #    :artist => params[:artist_name],
        #    :album => params[:album_name]
        #})
        #
        #if album = response["album"]
        #  output = Nestful.get(album["image"].last['#text'])
        #  send_data(output, :type => "image/jpeg", :disposition => 'inline')
        #  return
        #else
        #  render nothing: true, code: 404
        #end
        render nothing: true, code: 404
      end

      # list playlists

      def all_playlist_enum
        items = []

        #"id" : 0, "name" : "test", "type" : "smart_playlist"

        items << {
            id: -3,
            name: "Random 100",
            path: "/tmp/(null)==DynaRandom100==.m3u",
            type: "random100"
        }

        respond_with_items(items)
      end

      # list playlist tacks
      def playlist_song_enum
        #pls_id
        items = []
        respond_with_items(items)
      end

      def smartpls_song_enum
        items = []
        respond_with_items(items)
      end

      # list artists
      def artist_enum
        items = Artist.with_more_than_one_track.pluck(:name).map { |a| {name: a} }
        respond_with_items(items)
      end

      def album_enum
        scope = Release.scoped
        scope = scope.artist_name_eq(params[:artist_name]) if params.has_key?(:artist_name)
        items = scope.pluck(:title).map { |a| {name: a} }
        respond_with_items(items)
      end

      def song_enum
        scope = Track.scoped
        scope = scope.artist_name_eq(params[:artist_name]) if params.has_key?(:artist_name)
        scope = scope.release_title_eq(params[:album_name]) if params.has_key?(:album_name)
        #TODO: scope = scope.genre_name_eq(params[:genre_name]) if params.has_key?(:genre_name)

        items = []

        scope.each do |track|
          items << {
              :id => track.id.to_s,
              :path => track.id.to_s,
              :album => track.release.title,
              :albumartist => track.artist.name,
              :artist => track.artist.name,
              :bitrate => track.bitrate,
              :channel => track.channels,
              :comment => "",
              :composer => "",
              :covercount => 0,
              :disc => "1",
              :duration => track.length,
              :filesize => track.size,
              :frequency => track.sample_rate,
              :genre => '', # TODO: track.artist.genres.first,
              :title => track.title,
              :track => track.number.to_s,
              :year => '' # TODO: track.release.year
          }
        end

        respond_with_items(items)
      end

      # search tracks
      def search # Params: search_key
      end

      # list genres
      def genre_enum
        items = [{name: "Genre Name"}]
        respond_with_items(items)
      end

      # list folders
      def folder_enum
        items = Release.all.map { |release| {artist: release.artist, album: release.title} }
        respond_with_items(items)
      end

      # list radios
      def radio_enum
        items = []
        if params[:id]
          items << {
              :bitrate => 128000,
              :desc => "MP3 (128 kbps)",
              :id => "inetradio_genre_Alternative@1",
              :is_container => false,
              :path => "http://yp.shoutcast.com/sbin/tunein-station.pls?id=37586",
              :title => "181.FM - The Buzz (Your Alternative Station!) - a SHOUTcast.com member station"
          }
        else
          items << {id: "container", is_container: true, title: "Radio Container"}
        end
        respond_with_items(items)
      end
    end
  end
end