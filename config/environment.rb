# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Global quick domain helper
def qd(slug)
  Domain.current = Domain.find_by slug: slug
end
