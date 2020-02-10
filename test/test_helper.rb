ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...

  def presence_validations_test(object, attributes)
    attributes.each do |attribute|
      debugger unless object.valid?
      assert object.valid?
      original_attribute_value = object.send(attribute)
      object.send("#{attribute}=", nil)
      assert_not object.valid?
      assert object.errors[attribute.to_sym].include?("can't be blank")
      object.send("#{attribute}=", original_attribute_value)
      assert object.valid?
    end
  end
end
