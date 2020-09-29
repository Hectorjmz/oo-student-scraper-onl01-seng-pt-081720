require 'open-uri'
require 'nokogiri'
require 'json'
require 'pry'

class Scraper


  #is a class method that scrapes the student index page and a 
  #returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    Nokogiri::HTML.parse(open(index_url))
  end

  def self.scrape_profile_page(profile_url)
    
  end

  

end

