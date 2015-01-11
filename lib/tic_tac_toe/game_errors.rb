class GameErrors
  class InvalidActionError < StandardError
    def initialize(msg="This space has already been marked")
      super
    end
  end

  class InvalidCoordinateError < StandardError
    def initialize(msg="An invalid coordinate was passed in, please try again")
      super
    end
  end

  class InvalidCharacterError < StandardError
    def initialize(msg='Only "x" and "o" are valid character choices.')
      super
    end
  end
end
