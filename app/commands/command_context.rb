class CommandContext
  attr_accessor :params, :contract, :validated_params, :errors, :object, :success

  def initialize
    @params = {}
    @contract = nil
    @validated_params = {}
    @errors = {}
    @object = nil
    @success = true
  end

  def failure?
    !success
  end

  def success?
    success
  end
end