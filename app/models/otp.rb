class Otp < ApplicationRecord

  validates_presence_of :phone, :password, message: 'can\'t be blank'
  validates_numericality_of :phone, message: 'should only contain digits'
  validates_length_of :phone, is: 10, :message => 'should be 10 digits long'

  module Constants
    EXPIRY_DURATION = 3.minutes
  end

  def self.upsert_otp(phone, expiry)
    otp = Otp.where(phone: phone).first
    if otp.blank?
      Otp.new(phone: phone, password: self.generate_otp(otp), expiry: expiry)
    else
      otp.password = self.generate_otp(otp)
      otp.expiry = expiry
      otp
    end
  end

  def self.verify(phone, verifying_otp)
    otp = Otp.where(phone: phone).where('expiry > ?', Time.now).first
    return false if otp.blank?
    otp.password.eql?(verifying_otp) ? true : false
  end

  private

  def self.generate_otp(otp)
    new_otp = rand(0..999999).to_i.to_s.rjust(6, '0')
    if otp.blank?
      new_otp
    else
      otp.expiry > Time.now ? otp.password : new_otp
    end
  end

end
