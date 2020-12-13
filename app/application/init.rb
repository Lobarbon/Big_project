# frozen_string_literal: true

folders = %w[representers controllers services]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
