require 'open-uri'
require 'nokogiri'

def get_subpages(url)
  subpages = []
  
  html = URI.open(url)
  
  doc = Nokogiri::HTML(html)
  
  # Find all anchor tags
  doc.css('a').each do |link|
    href = link['href']
    
    if href && !href.start_with?('http')
      if href.start_with?('/')
        subpage_url = URI.join(url, href).to_s
      else
        subpage_url = URI.join(url, '/', href).to_s
      end
      
      # Add the sub-page URL to the list
      subpages << subpage_url
    end
  end
  
  return subpages
end

print "Enter the URL of the website: "
website_url = gets.chomp

subpages = get_subpages(website_url)

puts "Sub-pages of #{website_url}:"
subpages.each do |subpage|
  puts subpage
end

