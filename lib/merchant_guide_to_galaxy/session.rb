require 'singleton'
module MerchantGuideToGalaxy
  class Session
    include Singleton

    def initialize
      @convertion_map = {}
      @price_list= {}
      @romanize = Romanize.new
    end

    def add_price(material, price)
      @price_list[material] = price
    end

    def get_price(material)
      @price_list[material]
    end
    def add_convertion(word, roman_number)
      @convertion_map[word] = roman_number
    end

    def translate_galaxy_to_roman(input)
      input.split(' ').map do |w|
        @convertion_map[w]
      end.join('')
    end

    def translate_galaxy_to_number(input)
      @romanize.to_i translate_galaxy_to_roman(input)
    end
  end
end