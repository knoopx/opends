require 'shellwords'

module Audio
  module Ios
    module Streaming
      def transcoder
        #{"type"=>"mp3", "id"=>"143", "size"=>"1840000", "position"=>"0", "sessionid"=>"BAh7CEkiD3Nlc3Npb25faWQGOgZFRiJFZTA4Y2FjZWM5NjAxYjA5M2FiNWVh\nMTllYTgzMzIzOTE4ZTQzODE0NzEyZmY1MjRjMTMzZmYzMDcyYmU0M2UxM0ki\nCWNzcmYGOwBGIkUwMzhlMGE3YzA2ZDJiNmQ1ZDBmNjc2YzAxMDI0NzVhNTAy\nMGZmMTNhNWY4ZjBjYTEzZTJlMzhhODUyOTYzYmM5SSINdHJhY2tpbmcGOwBG\newhJIhRIVFRQX1VTRVJfQUdFTlQGOwBGIi1jZTQyNDZjMWFmMDBjZTIyZjdk\nYzk2MmMwYzU3MjdjZmRiYzliY2FiSSIZSFRUUF9BQ0NFUFRfRU5DT0RJTkcG\nOwBGIi1jYTU0NmUzNjliZWVjYWFlMzk2OGMxMjZmY2NiOGI1NDE1ZTRhZTg0\nSSIZSFRUUF9BQ0NFUFRfTEFOR1VBR0UGOwBGIi1kYTM5YTNlZTVlNmI0YjBk\nMzI1NWJmZWY5NTYwMTg5MGFmZDgwNzA5\n"}
        track = Track.find(params[:id])
        #track.increment!(:play_count, 1)
        path = File.join(track.release.path, track.filename)
        position = params[:position].try(:to_i) || 0
        minutes = position / 1.minute
        seconds = position - (minutes.minutes)
        self.response_body = IO.popen("mp3splt -f -o- #{path.shellescape} #{minutes}.#{seconds} EOF")
      end

      def stream
        #{"action"=>"streaming", "songpath"=>"/volume1/music/01_03_Its_A_Great_Thing.mp3", "seek_position"=>"0"}
        track = Track.find(params[:songpath])
        #track.increment!(:play_count, 1)
        send_file File.join(track.release.path, track.filename)
      end
    end
  end
end