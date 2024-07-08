# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    [
      Ability::Admin,
      Ability::Student,
      Ability::Teacher,
    ].each do |ability_class|
      merge(ability_class.new(user))
    end
  end
end
