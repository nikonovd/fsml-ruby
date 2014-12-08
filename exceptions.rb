module Exceptions

  class ValidatorException < Exception
  end

  class ParseException < Exception
  end

  class SingleInitialStateException < ValidatorException
  end

  class DistinctIdsException < ValidatorException
  end

  class DeterministicException < ValidatorException
  end

  class ResolvableException < ValidatorException
  end

  class ReachableException < ValidatorException
  end

end