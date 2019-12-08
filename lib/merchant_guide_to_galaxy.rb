require "merchant_guide_to_galaxy/version"
require "merchant_guide_to_galaxy/romanize"
require "merchant_guide_to_galaxy/input_parser"
require "merchant_guide_to_galaxy/session"
module MerchantGuideToGalaxy
  class Error < StandardError; end
  class Application
    def initialize
      @parser = InputParser.new
    end

    def read(msg)
      begin
        return @parser.parse(msg)
      rescue RuntimeError, "I have no idea what you are talking about"
        return "I have no idea what you are talking about"
      end
    end
  end
end
