module Sprites
  class Notifier
    def self.no_configured_or_imlicit_backend(print = true)
      msg = "We were unable to load your configured backend or any supported backends"
      $stdout << msg if print
      msg
    end
  end
end
