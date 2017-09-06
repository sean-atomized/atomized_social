class AtomizedSocial::Exceptions
  class BadAuthenticationError < StandardError
    def initialize(msg = 'Bad authentication data')
      super
    end
  end
end
