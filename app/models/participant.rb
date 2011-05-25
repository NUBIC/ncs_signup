class Participant < ActiveRecord::Base
  validates_presence_of :name, :message => "is required. Please provide your first and last name."
  validates_format_of :email, {
    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
    :on => :create,
    :allow_blank => true, 
    :message => "needs to be in the correct format (e.g. someone@somewhere.com)" }
  validate :at_least_one_phone_number 
  attr_accessor :phone_numbers

  def at_least_one_phone_number
    has_one_phone = !self.home_phone.blank? || !self.work_phone.blank? || !self.mobile_phone.blank?
    unless has_one_phone
      errors.add(:phone_numbers, "are required. Please provide at least one phone number.")
      errors.add(:home_phone, nil)
      errors.add(:work_phone, nil)
      errors.add(:mobile_phone, nil)
    end
  end
end
