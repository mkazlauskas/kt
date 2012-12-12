# Modulis, padedantis atlikti matematinius veiksmus
# ir skaiciavimus

module MathHelper
  def num_combinations(n, k)
    n.factorial / (k.factorial * (n - k).factorial)
  end
end

class Integer
  def factorial
    if self == 0
      1
    else
      self * (self - 1).factorial
    end
  end
end