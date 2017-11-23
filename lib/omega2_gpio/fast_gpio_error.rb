module Omega2Gpio

  class FastGpioError < StandardError
  end

  def raise_error(error)
    raise(FastGpioError, error.message)
  end
end