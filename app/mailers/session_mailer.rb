class SessionMailer < ActionMailer::Base
  # default from: 'john@example.com'

  def magic(email:, lnk:)
    @email, @lnk = email, lnk
    @domain = Domain.current
    mail from: @domain.email, to: email, template_name: 'magic', subject: "Log into #{@domain.name}"
  end

end
