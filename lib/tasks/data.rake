namespace :data do
  namespace :package do
    desc "Fetch MELPA package information"
    task :update => :environment do
      PackageUpdater.update
    end
  end

  namespace :cask do
    desc "Search on GitHub for Cask files"
    task :update => :environment do
      CaskUpdater.update(80)
    end
  end
end
