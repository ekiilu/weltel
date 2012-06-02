class SystemUser
  def self.get
    Authentication::User.first(:email => 'system@verticallabs.ca')
  end
end
