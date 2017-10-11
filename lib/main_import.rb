# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2017, Sebastian Staudt

require 'repository_import'

module MainImport

  include RepositoryImport

  def create_missing_taps
    official_taps.each do |tap|
      tap_name = "Homebrew/homebrew-#{tap}"

      repo = Repository.find tap_name
      if repo.nil?
        Repository.create name: tap_name, outdated: false

        Rails.logger.info "Created tap repository for #{tap_name}."
      elsif repo.outdated?
        repo.outdated = false
        repo.save!
      end
    end
  end

  def brew_taps
    official_taps_path = "#{path}/Library/Homebrew/official_taps.rb"
    official_taps_rb = File.read official_taps_path

    brew = Module.new
    brew.module_eval official_taps_rb, official_taps_path
    brew
  end

  def deprecated_official_taps
    brew_taps.const_get :DEPRECATED_OFFICIAL_TAPS
  end

  def official_taps
    brew_taps.const_get :OFFICIAL_TAPS
  end

  def update_deprecated_taps
    deprecated_official_taps.each do |tap|
      tap_name = "Homebrew/homebrew-#{tap}"

      repo = Repository.find tap_name
      unless repo.nil? || repo.outdated?
        repo.outdated = true
        repo.save
      end
    end
  end

  def update_status
    last_sha = super

    save! if last_sha != sha

    last_sha
  end

end
