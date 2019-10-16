require 'rubygems'
require 'nokogiri'

def get_townhall_data(townhall_url)
  # Renvoie l'adresse mail d'une mairie
  page = website_content(townhall_url) # chargement du contenu de la page

  # scrap méthode CSS
  #page.css('td')[7].text 

  # scrap méthode mailto : ne marche pas ici
  #page.xpath('//a[contains(@href, "mailto")]')

  # scrap méthode xpath

  townhall_name = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[1]/td[1]').text.to_s.gsub("Adresse mairie de ", "").downcase
  
  townhall_mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

  townhall_data_hash = { townhall_name => townhall_mail }

  #page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

  townhall_data_hash

end

#def get

def get_townhall_urls(departement_url)
  # Renvoi un array avec toutes les url de la page
  page = website_content(departement_url)
  
  website_url = "http://annuaire-des-mairies.com"

  data_townhall = page.css("a[class='lientxt']") 
  number_of_townhall = data_townhall.length
  
  townhall_url_array = []

    for townhall_index in (0..(number_of_townhall-1))
      
      townhall_end_of_url = data_townhall[townhall_index]['href'].delete_prefix(".")

      townhall_url = website_url + townhall_end_of_url

      townhall_url_array += [townhall_url]
    end 

    townhall_url_array

end

def get_all_townhall_email(departement_url)
  # Renvoie un array avec les email des mairies d'un departement

  townhall_url_array = get_townhall_urls(departement_url)
  
  townhall_email_array = []

  townhall_url_array.each do |townhall_url|
  # for townhall_index in (1..4)  
  #  townhall_url = townhall_url_array[townhall_index]
    townhall_email_array += [get_townhall_data(townhall_url)]
  end

  townhall_email_array
end 

def website_content(url)
  # Give the content of the website on the given url
  require 'restclient'
  Nokogiri::HTML(RestClient.get(url))
end

print "Voici les 10 premiers résultats : ", (get_all_townhall_email("https://annuaire-des-mairies.com/val-d-oise.html").first(10))
puts

#puts get_townhall_urls("https://annuaire-des-mairies.com/val-d-oise.html")

#puts get_townhall_data("http://www.annuaire-des-mairies.com/91/abbeville-la-riviere.html")
