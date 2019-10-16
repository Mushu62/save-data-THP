require_relative '../lib/mairie'

test_get_all_townhall_email = get_all_townhall_email("https://annuaire-des-mairies.com/val-d-oise.html")

describe "dark_trader metho that scraps crypto website " do
  it "gives an array " do
    expect(test_get_all_townhall_email.class.to_s).to eq('Array') 
  end
  it "the array contains hash " do
    expect(test_get_all_townhall_email[3].class.to_s).to eq('Hash') 
  end
  it "contains data " do
    expect(test_get_all_townhall_email.length > 5).to eq(true) 
  end
  it "Email contains @ " do
    expect(test_get_all_townhall_email[3].values[0].include? "@" ).to eq(true) 
  end

end