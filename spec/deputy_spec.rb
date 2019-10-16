require_relative '../lib/deputy'

# Test takes 40 seconds to 

test_get_all_deputy_data = get_all_deputy_data

describe "get_all_deputy_data method " do
  it "returns an array " do
    expect(test_get_all_deputy_data.class.to_s).to eq('Array') 
  end
  it "the array contains hash " do
    expect(test_get_all_deputy_data[3].class.to_s).to eq('Hash') 
  end
  it "contains data " do
    expect(test_get_all_deputy_data.length > 5).to eq(true) 
  end

end
