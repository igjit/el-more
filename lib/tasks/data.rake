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

  namespace :cask_dependency do
    desc "Update package dependencies of Cask"
    task :update => :environment do
      CaskDependencyUpdater.update(100)
    end
  end

  namespace :user_attributes do
    desc "Update user attributes"
    task :update => :environment do
      access_token = ENV['GITHUB_ACCESS_TOKEN'] or
        raise "Environment variable GITHUB_ACCESS_TOKEN is not defined."

      UserAttributesUpdater.update User.all, access_token
    end
  end
end
