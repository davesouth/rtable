class SessionMailer < ActionMailer::Base
  default from: 'RTable CRM <barney@rtable.apped.us>'

  def magic(email:, lnk:)
    @email, @lnk = email, lnk
    @domain = Domain.current
    mail to: email, template_name: 'magic', subject: "Log into #{@domain.name}"
  end

end
