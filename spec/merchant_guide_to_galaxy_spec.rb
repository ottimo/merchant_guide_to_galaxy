RSpec.describe MerchantGuideToGalaxy do
  let(:app){ MerchantGuideToGalaxy::Application.new}
  it "has a version number" do
    expect(MerchantGuideToGalaxy::VERSION).not_to be nil
  end

  test_value = {
    "glob means I" => nil,
    "prok means V" => nil,
    "pish means X" => nil,
    "tegj means L" => nil,
    "glob glob units of Silver are worth 34 Credits" => nil,
    "glob glob units of Copper are worth 4 Credits" => nil,
    "glob prok units of Gold are worth 57800 Credits" => nil,
    "pish pish units of Iron are worth 3910 Credits" => nil,
    "how much is pish tegj glob glob ?" => "pish tegj glob glob is 42",
    "how many Credits is glob prok Silver ?" => "glob prok Silver is 68 Credits",
    "how many Credits is glob prok Gold ?" => "glob prok Gold is 57800 Credits",
    "how many Credits is glob prok Iron ?" => "glob prok Iron is 782 Credits",
    "how many Credits is glob prok Copper ?" => "glob prok Copper is 8 Credits",
  }
  it "handle msg" do

  end
end
