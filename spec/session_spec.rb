RSpec.describe MerchantGuideToGalaxy::Session do
  let(:session){ MerchantGuideToGalaxy::Session.instance }
  before(:each) do
    session.add_convertion('glob','I')
    session.add_convertion('prok','V')
    session.add_convertion('pish','X')
    session.add_convertion('tegj','L')
  end
  test_values = {
    "glob glob" => "II",
    "glob prok" => "IV",
    "pish pish" => "XX",
    "pish tegj glob glob" => 'XLII',
  }

  test_values.each do |galaxy, roman|
    it "#{galaxy} is converted in #{roman}" do
      expect(session.translate_galaxy_to_roman(galaxy)).to eq roman
    end
  end

  test_values = {
    "glob glob" => 2,
    "glob prok" => 4,
    "pish pish" => 20,
    "pish tegj glob glob" => 42,
  }

  test_values.each do |galaxy, number|
    it "#{galaxy} is converted in #{number}" do
      expect(session.translate_galaxy_to_number(galaxy)).to eq number
    end
  end
end