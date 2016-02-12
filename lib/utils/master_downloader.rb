#!/usr/bin/env ruby
# require 'English'
require 'action_view'
require 'algoliasearch'
require 'date'
require 'fileutils'
require 'json'
require 'nokogiri'

# Télécharger des fichiers
# Les stocker en cache
# Extraire les data
# Les stocker en JSON
# Pusher sur Algolia

# Provides convenience methods for scrapping and saving data
# Also provides a few expected methods that any Downloader should implement
module MasterDownlOADER



  # def filepath_from_args(args)
  #   args.map { |arg| File.expand_path(arg) }
  # end

  # def get_tweet_count(url)
  #   twitter_api_url = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
  #   data = JSON.parse(`wget --random-wait -q -O - "#{twitter_api_url}"`)
  #   data['count']
  # end



end
