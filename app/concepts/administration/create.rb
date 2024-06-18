class Administration::Create < Trailblazer::Operation
  setp Model(Administration, :new)
  step Contract::Build(constant: Administration::Contract::Create)
  step Contract::Validate(key: :administration)
  step Contract::Persist()
end
