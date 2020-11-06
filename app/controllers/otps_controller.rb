class OtpsController < APIController
  def create
    otp = Otp.upsert_otp(otp_params[:phone], Time.now + Otp::Constants::EXPIRY_DURATION)
    if otp.valid?
      otp.save!
      response = { password: otp.password }
      render_success(response, ["OTP sent to #{otp.phone}"], :created)
    else
      render_error(otp.errors.full_messages)
    end
  end

  private

  def otp_params
    params.permit(:phone)
  end
end
