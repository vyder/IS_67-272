class Host < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :first_name,
									:last_name,
									:username, 
									:email, 
									:password, 
									:password_confirmation
  attr_accessor :password
  before_save :prepare_password

	# Relationships
	has_many :parties
	has_many :guests
	has_many :locations

	# Scopes - none

	# Validations
	validates_presence_of :first_name, :last_name
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, 
																 :allow_blank => true, 
																 :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, 
																 :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    host = find_by_username(login) || find_by_email(login)
    return host if host && host.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
end
