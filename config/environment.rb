# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Global quick domain helper
def qd(id)
  Domain.current = Domain.find_by_host_id(id)
end
