require 'dry-validation'

Dry::Validation::Contract.register_macro(:uuid_v4?) do
  unless /\A\h{8}-\h{4}-\h{4}-\h{4}-\h{12}\z/i.match?(value)
    key.failure('must be a valid UUID v4')
  end
end
