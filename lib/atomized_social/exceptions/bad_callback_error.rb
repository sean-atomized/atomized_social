class AtomizedSocial::Exceptions
  class BadCallbackError < StandardError
    def initialize(msg = 'Bad callback url')
      super
    end
  end
end
