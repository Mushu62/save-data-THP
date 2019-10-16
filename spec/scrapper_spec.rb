require_relative '../lib/scrapper'

# Test takes 40 seconds to 

test_dark_trader = dark_trader(80) # Mettre 0 pour lancer sur toutes les valeurs

describe "dark_trader metho that scraps crypto website " do
  it "gives an array " do
    expect(test_dark_trader.class.to_s).to eq('Array') 
  end
  it "the array contains hash " do
    expect(test_dark_trader[3].class.to_s).to eq('Hash') 
    expect(test_dark_trader[5].class.to_s).to eq('Hash') 
    expect(test_dark_trader[9].class.to_s).to eq('Hash') 
  end
  it "the key of hash is a string shorter than 5" do
    expect(test_dark_trader[3].keys[0].class.to_s).to eq('String')
    expect(test_dark_trader[3].keys[0].length < 5).to eq(true)
    expect(test_dark_trader[8].keys[0].class.to_s).to eq('String')
    expect(test_dark_trader[8].keys[0].length < 5).to eq(true)
  end

  it "the value of hash is a float" do
    expect(test_dark_trader[3].values[0].class.to_s).to eq('Float')
    expect(test_dark_trader[8].values[0].class.to_s).to eq('Float')
  end


end