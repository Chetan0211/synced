class Signing::Contract::UserCreate < ApplicationContract
  include Composition
  
  model :user, from: User::Contract::Create
  model :administration, from: Administration::Contract::Create

  property :first_name, on: :user
  property :last_name, on: :user
  # This specifies that the property :user_email on the contract/form 
  # object should map to the :email property on the User model.
  property :user_email, on: :user, from: :email  
  property :personal_email, on: :user
  property :password, on: :user
  property :user_type, on: :user
  property :confirm_password, virtual: true

  property :name, on: :administration
  property :administration_email, on: :administration, from: :email
  property :email_identifier, on: :administration

  validate :validate_user_contract
  validate :validate_administration_contract

  private

  def validate_user_contract
    user_instance = User.new(to_nested_hash[:user])
    user_contract = User::Contract::Create.new(user_instance)
    user_contract.confirm_password = confirm_password
    unless user_contract.validate(key: :user)
      user_contract.errors.each do |field, error|
        errors.add("user_#{field.attribute}", field.options[:message])
      end
    end
  end

  def validate_administration_contract
    administration_instance = Administration.new(to_nested_hash[:administration])
    admin_contract = Administration::Contract::Create.new(administration_instance)
    unless admin_contract.validate(key: :administration)
      admin_contract.errors.each do |field, error|
        errors.add("administration_#{field.attribute}", field.options[:message])
      end
    end
  end
end