require 'rubygems'
require 'nokogiri'

# 2019-10-09 -THP Scrapper Project
# http://ruby.bastardsbook.com/chapters/html-parsing/

#___________ Main Methods ___________#

def dark_trader(nb_of_crypto_scrapped = 0)
  # Give an array of hash of scrapped crypto 

  website_url = "https://coinmarketcap.com/all/views/all/" # Web site to analyse
  
  page = website_content(website_url) # 

  crypto_array = [] # init the crypto array
  
  # Calculate the number of cryto
  (nb_of_crypto_scrapped == 0) ? nb_crypto = nb_max_of_crypto(page) - 1 : nb_crypto = nb_of_crypto_scrapped   

  for index in (0..nb_crypto) # Loop for all the crypto
    crypto_array += [one_crypto_hash(page,index)] # Filling the crypto array 
  end
  
  crypto_array # result
  
end

#___________ Secondary Methods ___________#


def website_content(url)
  # Give the content of the website on the given url
  require 'restclient'
  Nokogiri::HTML(RestClient.get(url))
end

def one_crypto_hash(page,index)
  # Build hash for one crypto with { crypto_name and crypto value }
  { get_crypto_name(page, index) => get_crypt_value(page, index) }
end 

def get_crypto_name(page, index)
  # Scrap crypto_name 
  page.css('td[class="text-left col-symbol"]')[index].text
end

def nb_max_of_crypto(page)
  # Calculate the number of crypto
  page.css('td[class="text-left col-symbol"]').length
end

def get_crypt_value(page, index)
  # Scrap crypto value 
  page.css('a[class="price"]')[index]['data-usd'].to_f
end

#___________ Testing ___________#


print "Voici les 10 premiers résultats :" , dark_trader(10)
puts

def save_as_json(department_url)
  #Méthodes récupérant un array pour les emails et un pour les noms
          names = get_city_names(department_url) 
          emails = scrapping(department_url)
  #Création d'un hash vide pour recevoir chaque couple name:email
          temp_hash = Hash.new
  #Boucle qui associe chaque nom à l'email ayant le même index et stocke chaque paire dans le hash
          i = 0
          (names.length).times do
              temp_hash[names[i]] = emails[i]
              i += 1
          end
  #création du fichier tonhalls_and_emails.json dans le dossier db et son remplissage avec le hash
          File.open("emails.json","w") do |f|
                f.write(temp_hash.to_json)
          end
      end

#___________ Archives ___________#

def test_open_by_local
  page = Nokogiri::HTML(open("index.html"))   
  puts page.class   # => Nokogiri::HTML::Document
end 

def test_open_by_uri
  require 'open-uri'
  page = Nokogiri::HTML(open("http://en.wikipedia.org/"))   
  puts page.class   # => Nokogiri::HTML::Document
end

def test_open_by_restclient
  require 'restclient'
  page = Nokogiri::HTML(RestClient.get("http://en.wikipedia.org/"))   
  puts page.class   # => Nokogiri::HTML::Document
end

def save_as_JSON
end
