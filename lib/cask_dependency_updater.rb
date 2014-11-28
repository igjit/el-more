require 'open-uri'
require 'cask_parser'

module CaskDependencyUpdater
  module_function

  def update(limit, reader: nil)
    reader ||= ->(cask) { sleep 1; open(cask.raw_url) { |f| f.read } }

    casks = Cask.joins(:user).order("users.followers DESC")
    casks.lazy.select do |cask|
      begin
        save_package_dependencies! cask, reader unless cask.read
        cask.configuration
      rescue => e
        warn "#{e} : Cask id = #{cask.id}"
        false
      end
    end.take(limit).force
  end

  def save_package_dependencies!(cask, reader)
    Cask.transaction do
      text = reader.call(cask)
      content = CaskParser.new text
      config = content.configuration?
      cask.configuration = config

      if config
        cask.packages = Package.where(name: content.dependencies)
      end

      cask.read = true
      cask.save!
    end
  end

  def delete_all
    Cask.transaction do
      Cask.update_all(read: false, configuration: nil)
      CaskPackage.delete_all
    end
  end
end
