class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Perform the job
    puts "Performing job with args: #{args.inspect}"
    
  end
end