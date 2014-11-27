namespace :data do
  namespace :package do
    desc "Fetch MELPA package information"
    task :update => :environment do
      PackageUpdater.update
    end
  end
end
