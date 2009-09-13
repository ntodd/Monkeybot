class Admin
  class << self; attr_accessor :listeners_active; end
  @listeners_active = true
end