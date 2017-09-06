class AtomizedSocial::Exceptions
  class UnsupportedNetworkError < StandardError
    def initialize(msg = 'Unsupported social network')
      super
    end
  end
end
