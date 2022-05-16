class SessionMailer < ActionMailer::Base
  default from: 'Spherus CRM <barney@spherus.apped.us>'

  def magic(email:, lnk:)
    @email, @lnk = email, lnk
    @domain = Domain.current
    mail to: email, template_name: 'magic', subject: "Log into Spherus CRM"
  end

end
