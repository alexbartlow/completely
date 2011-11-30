require 'builder'
module Completely
  class Base
    class << self
      def steps=(steps)
        @steps = steps
      end

      def list_elt(*args)
        if args.empty?
          @list_elt || 'ul'
        else
          @list_elt = args[0]
        end
      end

      def item_elt(*args)
        if args.empty?
          @item_elt || 'li'
        else
          @item_elt = args[0]
        end
      end

      def completed_class(*args)
        if args.empty?
          @completed_class || 'completed'
        else
          @completed_class = args[0]
        end
      end

      def steps
        @steps ||= []
      end

      def step(name, &block)
        steps << Step.new.tap do |s|
          s.name = name
          s.block = block
        end
      end
    end

    def steps
      @steps ||= self.class.steps.map do |step|
        si = StepInstance.new
        si.object @object
        si.instance_eval(&step.block)
        si.name ||= step.name
        si
      end
    end

    def initialize(object)
      @object = object
    end

    def to_html
      html = Builder::XmlMarkup.new
      tag, *classes = *self.class.list_elt.split('.')
      html.__send__(tag, :class => classes.join(" ")) do
        tag, *classes = *self.class.item_elt.split('.')
        self.steps.each do |step|
          classes = classes.dup
          classes = classes + [self.class.completed_class] if step.completed
          html.__send__(tag, :class => classes.join(" ")) do
            html.a(:href => step.path) do
              html.text! step.name
            end
          end
        end
      end
      html.target!
    end
  end

  class Step
    attr_accessor :name
    attr_accessor :block
  end

  class StepInstance
    attr_accessor :name
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
