module MerchantGuideToGalaxy
  class Romanize

    VALUES = {
      M: 1000, 
      D: 500, 
      C: 100, 
      L: 50, 
      X: 10, 
      V: 5, 
      I: 1
    }

    SYNTAX_CHECK = Regexp.new(/^(?=[MDCLXVI])M{0,3}(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$/).freeze


    def to_i(roman)
      unless SYNTAX_CHECK.match?(roman)
        raise RuntimeError, "#{roman} is not a valid number"
      end
      result = 0
      last_value = 0
      roman.to_s.reverse.each_char do |roman_value|
        value = VALUES[roman_value.to_sym]
        if value >= last_value
          result += value
          last_value = value
        else
          result -= value
        end
      end
      result
    end

  end
end