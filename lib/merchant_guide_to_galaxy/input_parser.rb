module MerchantGuideToGalaxy
  class InputParser

    MEANS_CHECK = Regexp.new(/^(\w*)\s*means\s*([IVXLCDM]){1}$/i).freeze
    PRICE_DEFINITION_CHECK = Regexp.new(/^([\w\s]*)units of (\w*) are worth (\d*) Credits$/i).freeze
    COUNT_CHECK = Regexp.new(/^how much is ([\w\s]*)\?$/i).freeze
    PRICE_CHECK = Regexp.new(/^how many Credits is ([\w\s]*)\?$/i).freeze

    def means_action(ret)
      Session.instance.add_convertion(ret.first, ret.last)
      return
    end

    def price_definition_action(ret)
      credits = ret.last
      material = ret[1]
      units = Session.instance.translate_galaxy_to_number(ret.first)
      Session.instance.add_price(material, credits.to_f/units.to_i)
      return
    end

    def count_action(ret)
      value = Session.instance.translate_galaxy_to_number(ret.first)
      reply = "#{ret.first}is #{value}"        
      return reply
    end

    def price_action(ret)
      ret = ret.join.split(' ')
      material = ret.pop
      galaxy = ret.join ' '
      units = Session.instance.translate_galaxy_to_number(galaxy)
      value = units.to_f * Session.instance.get_price(material)
      reply = "#{galaxy} #{material} is #{value.to_i} Credits"
      return reply
    end

    def parse(input)
      if MEANS_CHECK.match?(input)
        ret = input.to_s.scan(MEANS_CHECK)
        results = ret.flatten
        return means_action(results)
      elsif PRICE_DEFINITION_CHECK.match?(input)
        ret = input.to_s.scan(PRICE_DEFINITION_CHECK)
        results = ret.flatten
        return price_definition_action(results)
      elsif COUNT_CHECK.match?(input) 
        ret = input.to_s.scan(COUNT_CHECK)
        results = ret.flatten
        return count_action(results)
      elsif PRICE_CHECK.match?(input)
        ret = input.to_s.scan(PRICE_CHECK)
        results = ret.flatten
        return price_action(results)
      end
      raise RuntimeError, "I have no idea what you are talking about"
    end
  end
end