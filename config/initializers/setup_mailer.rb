ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "partymanager.mailer",
  :password             => "totallySecret",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
