class Integer
  def factorial
    return 1 if self == 0
    self * (self - 1).factorial
  end
end