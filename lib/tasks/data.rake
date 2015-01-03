namespace :data do
  def ensure_github_access_token
    ENV['GITHUB_ACCESS_TOKEN'] or
      raise "Environment variable GITHUB_ACCESS_TOKEN is not defined."
  end

  namespace :package do
    desc "Fetch MELPA package information"
    task :update => :environment do
      PackageUpdater.update
    end
  end

  namespace :package_similarity do
    desc "Calculate package similarity"
    task :update => :environment do
      PackageSimilarityUpdater.delete_all
      PackageSimilarityUpdater.update
    end
  end

  namespace :cask do
    desc "Search on GitHub for Cask files"
    task :initial_import => :environment do
      CaskUpdater.update(80)
    end

    desc "Search on GitHub for recently updated Cask files"
    task :update => :environment do
      require 'cask_updater'
      CaskUpdater.update(5, search: CaskUpdater::SEARCH_RECENTLY_INDEXED)
    end
  end

  namespace :cask_dependency do
    desc "Update package dependencies of Cask"
    task :update => :environment do
      CaskDependencyUpdater.update(100)
    end

    desc "Delete package dependencies of all Cask"
    task :delete => :environment do
      CaskDependencyUpdater.delete_all
    end
  end

  namespace :user_attributes do
    desc "Update user attributes"
    task :update => :environment do
      access_token = ensure_github_access_token
      UserAttributesUpdater.update User.all, access_token
    end
  end

  namespace :all do
    desc "Update all data"
    task :update => :environment do
      tasks = %w(data:package:update
                 data:cask:update
                 data:user_attributes:update
                 data:cask_dependency:update
                 data:package_similarity:update)

      ensure_github_access_token

      tasks.each do |task|
        puts "Task: #{task}"
        Rake::Task[task].invoke
      end
    end
  end
end
