module Completely
  class StepInstance
    attr_accessor :name
    attr_accessor :step
    def method_missing(symb, *args, &block)
      ivar = '@'+symb.to_s
      if args.empty?
        instance_variable_get(ivar)
      else
        instance_variable_set(ivar, *args)
      end
    end
  end
end
