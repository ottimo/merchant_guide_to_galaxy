RSpec.describe MerchantGuideToGalaxy::InputParser do
  let(:parser){ MerchantGuideToGalaxy::InputParser.new }

  test_value = [
    "glob means I",
    "prok means V",
    "pish means X",
    "tegj means L",
    "glob glob units of Silver are worth 34 Credits",
    "glob prok units of Gold are worth 57800 Credits",
    "pish pish units of Iron are worth 3910 Credits",
  ]
  #   "how much is pish tegj glob glob ?",
  #   "how many Credits is glob prok Silver ?",
  #   "how many Credits is glob prok Gold ?",
  #   "how many Credits is glob prok Iron ?",
  # ]

  test_value.each do |input|
    it "#{input} recognizes" do
      expect(parser.parse(input)).to eq nil
    end
  end

  context "Setting convertion map" do
    test_value = {
      "glob means I": ['glob', 'I'],
      "prok means V": ['prok', 'V'],
      "pish means X": ['pish', 'X'],
      "tegj means L": ['tegj', 'L'],
    }
    test_value.each do |input, values|
      it "#{input} recognizes" do
        parser.parse(input)
        convertion_map = MerchantGuideToGalaxy::Session.instance.instance_variable_get(:@convertion_map)
        expect(convertion_map[values.first]).to eq values.last
      end
    end
  end

  it "set price list" do
    test_strings = [
      "glob means I",
      "prok means V",
      "pish means X",
      "tegj means L",
      "glob glob units of Silver are worth 34 Credits",
      "glob prok units of Gold are worth 57800 Credits",
      "pish pish units of Iron are worth 3910 Credits"
    ]
    test_strings.each do |s|
      parser.parse s
    end
    price_list = MerchantGuideToGalaxy::Session.instance.instance_variable_get(:@price_list)
    expect(price_list['Silver']).to eq 17.to_f
    expect(price_list['Gold']).to eq 57800.to_f/4
    expect(price_list['Iron']).to eq 3910.to_f/20
  end

  wrong_values = [
    "how much wood could a woodchuck chuck if a woodchuck could chuck wood ?",
    "igne means Z",
  ]
  wrong_values.each do |wrong_value|
    it "#{wrong_value} raise an exception" do
      expect {parser.parse(wrong_value)}.to raise_error(RuntimeError, "I have no idea what you are talking about")
    end
  end
end