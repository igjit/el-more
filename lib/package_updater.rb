require 'melpa_fetcher'

module PackageUpdater
  module_function

  def update
    cols = %w(url repo_type description)

    MelpaFetcher.new.packages.each do |package|
      old_package = Package.find_by(name: package.name)
      if old_package
        new_attr = package.attributes.slice(*cols)
        old_package.update_attributes!(new_attr)
      else
        package.save!
      end
    end
  end
end
