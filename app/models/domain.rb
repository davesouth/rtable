class Domain
  # Thread safe class attribute to store current domain
  thread_mattr_accessor :current

  def self.domains
    App[:domains]
  end

  def self.find_by_host(host)
    new(domains[host])
  end

  def self.find_by_host_id(id)
    new(domains.values.find{ |a| a[:id] == id })
  end

  # Instance options
  attr_reader :options

  def initialize(options)
    @options = options.with_indifferent_access
  end

private

  # Enumerate options as methods
  def method_missing(method_name)
    options[method_name] if options.key? method_name
  end

  def respond_to_missing?(method_name, *args)
    options.key? method_name
  end

end
