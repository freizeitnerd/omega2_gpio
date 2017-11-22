module Omega2Gpio
  def raise_error(error)
    raise(FastGpioError, error.message)
  end
end