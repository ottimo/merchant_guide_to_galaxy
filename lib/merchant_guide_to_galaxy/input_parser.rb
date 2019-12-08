module MerchantGuideToGalaxy
  class InputParser

    MEANS_CHECK = Regexp.new(/^(\w*)\s*means\s*([IVXLCDM]){1}$/i).freeze
    PRICE_DEFINITION_CHECK = Regexp.new(/^([\w\s]*)units of (\w*) are worth (\d*) Credits$/i).freeze
    COUNT_CHECK = Regexp.new(/^how much is ([\w\s]*)\?$/i).freeze
    PRICE_CHECK = Regexp.new(/^how many Credits is ([\w\s]*)\?$/i).freeze

    def parse(input)
      if MEANS_CHECK.match?(input)
        ret = input.to_s.scan(MEANS_CHECK)
        results = ret.flatten
        Session.instance.add_convertion(results.first, results.last)
        return
      elsif PRICE_DEFINITION_CHECK.match?(input)
        ret = input.to_s.scan(PRICE_DEFINITION_CHECK)
        ret.flatten!
        credits = ret.last
        material = ret[1]
        units = Session.instance.translate_galaxy_to_number(ret.first)
        Session.instance.add_price(material, credits.to_f/units.to_i)
        return
      elsif COUNT_CHECK.match?(input) 
        ret = input.to_s.scan(COUNT_CHECK)
        ret.flatten!
        value = Session.instance.translate_galaxy_to_number(ret.first)
        reply = "#{ret.first}is #{value}"        
        return reply
      elsif PRICE_CHECK.match?(input)
        ret = input.to_s.scan(PRICE_CHECK)
        ret = ret.flatten.join.split(' ')
        material = ret.pop
        galaxy = ret.join ' '
        units = Session.instance.translate_galaxy_to_number(galaxy)
        value = units.to_f * Session.instance.get_price(material)
        reply = "#{galaxy} #{material} is #{value.to_i} Credits"
        return reply
      end
      raise RuntimeError, "I have no idea what you are talking about"
    end
  end
end