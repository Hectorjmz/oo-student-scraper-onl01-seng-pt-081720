require 'open-uri'
require 'nokogiri'
require 'json'
require 'pry'

class Scraper


  #is a class method that scrapes the student index page and a 
  #returns an array of hashes in which each hash represents one student


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    
    doc.css("div.student-card").each do |student|
      hash_student = {}

      hash_student[:name] = student.css("h4.student-name").text
      hash_student[:location] = student.css("p.student-location").text
      hash_student[:profile_url] = student.css("a").attribute("href").value
      scraped_students << hash_student
    end
    scraped_students
  end



  

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    att_hash = {}
    
    if !doc.css("div.social-icon-container a")[0].attribute("href").value.empty?
      att_hash[:twitter] = doc.css("div.social-icon-container a")[0].attribute("href").value
    end
    
    if !doc.css("div.social-icon-container a")[1].attribute("href").value.empty?
      att_hash[:linkedin] = doc.css("div.social-icon-container a")[1].attribute("href").value
    end

    if !doc.css("div.social-icon-container a")[2].attribute("href").value.empty?
      att_hash[:github] = doc.css("div.social-icon-container a")[2].attribute("href").value
    end

    if !profile_url.empty?
      att_hash[:blog] = "https://#{profile_url.split('/').last.}"
    end

    if !doc.css("div.profile-quote").text.empty?
      att_hash[:profile_quote] = doc.css("div.profile-quote").text
    end

    if !doc.css("div.description-holder p")[0].text.empty?
      att_hash[:bio] = doc.css("div.description-holder p")[0].text
    end
    #----------------------------------------------------------------------------------------------------
     
    # if !doc.css("div.description-holder")[0].text.empty?
    #   att_hash[:bio] = doc.css("div.description-holder")[0].text
    # end

    # if !doc.css("div.profile-quote").text.empty?
    #   att_hash[:profile_quote] = doc.css("div.profile-quote").text
    # end

    # if !doc.css("div.social-icon-container a")[0].attribute("href").value.empty?
    #   att_hash[:twitter] = doc.css("div.social-icon-container a")[0].attribute("href").value
    # end
    
    # if !doc.css("div.social-icon-container a")[1].attribute("href").value.empty?
    #   att_hash[:linkedin] = doc.css("div.social-icon-container a")[1].attribute("href").value
    # end

    # if !doc.css("div.social-icon-container a")[2].attribute("href").value.empty?
    #   att_hash[:github] = doc.css("div.social-icon-container a")[2].attribute("href").value
    # end


    att_hash
   
    

  end

  

end

