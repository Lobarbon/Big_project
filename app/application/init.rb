# frozen_string_literal: true

folders = %w[controllers services representers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
