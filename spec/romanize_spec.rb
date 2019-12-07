RSpec.describe MerchantGuideToGalaxy::Romanize do
  let(:converter){ MerchantGuideToGalaxy::Romanize.new }

  it "I" do
    expect(converter.to_i('I')).to eq 1
  end
  
  test_value = {
    1903 => "MCMIII",
    1000 => "M",  
    900 => "CM",  
    500 => "D",  
    400 => "CD",
    100 => "C",  
    90 => "XC",  
    50 => "L",  
    40 => "XL",  
    10 => "X",  
      9 => "IX",  
      5 => "V",  
      4 => "IV",
      3 => "III",  
      2 => "II",
      1 => "I",  
  }

  test_value.each do |number,roman|
    it "#{roman} is converted in #{number}" do
      expect(converter.to_i(roman)).to eq number
    end
  end

  wrong_values = [
    "VV",
    "MMMM",
    "IIII",
    "XXXX",
    "CCCC",
    "IIV",
    "VX",

  ]
  wrong_values.each do |wrong_value|
    it "#{wrong_value} raise an exception" do
      expect {converter.to_i(wrong_value)}.to raise_error(RuntimeError, "#{wrong_value} is not a valid number")
    end
  end
end