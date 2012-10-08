namespace :opends do
  namespace :audio do
    task :index => :environment do
      Audio::Indexer.run
    end
  end
end