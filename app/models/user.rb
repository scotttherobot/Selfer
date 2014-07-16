class User < ActiveRecord::Base
   self.per_page = 10

   has_many :articles, :dependent => :delete_all
   has_many :posts, :dependent => :delete_all
   has_many :comments, :dependent => :delete_all

   attr_accessor :password
   before_save :encrypt_password
   after_initialize :init
   
   validates_confirmation_of :password
   validates_presence_of :password, :on => :create
   validates_presence_of :email
   validates_uniqueness_of :email

   has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
   validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

   def init
      # Default our users to the standard role
      self.role ||= 1
   end

   def self.authenticate(email, password)
      user = find_by_email(email)
      #if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      if user && BCrypt::Password.new(user.password_hash) == password
         user
      else
         nil
      end
   end

   def is_admin
      # Role 2 == admin, Role 1 == user
      return Integer(self.role) == 2
   end

   # Promote a user to admin
   def make_admin
      self.role = 2
   end

   def encrypt_password
      if password.present?
         self.password_hash = BCrypt::Password.create(password)
         #self.password_salt = BCrypt::Engine.generate_salt
         #self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
   end

end
