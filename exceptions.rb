module Exceptions

  class FSMLException < Exception
  end

  class ValidatorException < FSMLException
  end

  class ParseException < FSMLException
  end

  class SimulationException < FSMLException
  end

  class IllegalInputException < SimulationException
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