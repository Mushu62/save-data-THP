require 'rubygems'
require 'nokogiri'


def website_content(url)
  # Give the content of the website on the given url
  require 'restclient'
  Nokogiri::HTML(RestClient.get(url))
end

def get_deputy_data(deputy_url)
  # Renvoie l'adresse mail d'un députy
  page = website_content(deputy_url) # chargement du contenu de la page

  email = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  email_split_array = email.gsub("@",".").split(".")
  first_name = email_split_array[0]
  last_name = email_split_array[1]

  { 
    "first_name" => first_name,
    "last_name" => last_name,
    "email" => email
  }
  
end

def get_deputy_url_array

  url_of_list_of_deputy = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  website_url = "http://www2.assemblee-nationale.fr"

  page = website_content(url_of_list_of_deputy)

  deputy_url_array = []

  data_deputy = page.xpath('//a[contains(@href, "/deputes/fiche")]')
  nb_of_deputy = data_deputy.length

  for deputy_index in (0..15)#(nb_of_deputy-1))
    deputy_end_of_url = data_deputy[deputy_index]['href']
    
    deputy_url =  website_url + deputy_end_of_url.to_s

    deputy_url_array += [deputy_url]

  end 

  deputy_url_array
end

def get_all_deputy_data
  # Renvoie un array avec les emails des mairies d'un departement
  url_of_list_of_deputy = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

  deputy_url_array = get_deputy_url_array
  
  deputy_data_array = []

  deputy_url_array.each do |deputy_url|

    deputy_data_array += [get_deputy_data(deputy_url)]
  end

  deputy_data_array
end 

print "Voici les 5 premiers résultats:" , get_all_deputy_data[5]
puts

#puts get_deputy_url_array

#puts get_deputy_data("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA721410")