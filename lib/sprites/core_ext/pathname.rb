require 'pathname'

class Pathname
  def self.wrap(val)
    val.is_a?(Pathname) ? val : Pathname.new(val)
  end
end
