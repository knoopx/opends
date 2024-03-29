require 'fileutils'

module Audio
  class Indexer
    class << self
      def run
        OpenDS::Application.config.music_paths.each do |path|
          each_release(path) do |release_path|
            index_release(release_path)
          end
        end
      end

      protected

      def each_release(source, &block)
        raise "No block given" unless block_given?
        raise "#{source} is not a directory" unless File.directory?(source)

        releases = []

        Dir.glob(File.join(source, "**", "*.mp3")).each do |file|
          release_path = File.expand_path(File.dirname(file))
          unless releases.include?(release_path)
            releases << release_path
            yield(release_path)
          end
        end
      end

      def index_release(release_path)
        puts " * Processing #{File.basename(release_path)}"
        begin
          Release.transaction do
            Release.find_or_create_by_path(release_path)
          end
        rescue ::Exception => e
          puts " !!! #{e}:\r\n#{e.backtrace.join("\r\n")}"
        end
      end
    end
  end
end