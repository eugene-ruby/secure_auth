class CommandBase
  attr_accessor :context

  class << self
    attr_accessor :contract_class

    def contract(&block)
      @contract_class = Class.new(CommandContract, &block)
    end
  end

  def contract
    @contract ||= self.class.contract_class.new
  end

  def initialize
    @context = CommandContext.new
  end

  def call(params: {})
    context.params = params
    return self unless validate_contract!

    execute
    self
  end

  private

  def execute
    raise NotImplementedError, 'Subclasses must define the execute method'
  end

  def validate_contract!
    result = contract.call(context.params)

    if result.failure?
      context.errors = result.errors.to_h
      context.success = false
    else
      context.validated_params = result.to_h
    end

    result.success?
  end
end
