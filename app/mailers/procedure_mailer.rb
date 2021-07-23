class ProcedureMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.procedure_mailer.approved_procedure.subject
  #
  def approved_procedure
    @email = params[:email]
    @procedure = params[:procedure]
    @admin = params[:admin]

    mail(
      # from: ENV['EMAIL'],
      to: @email,
      # cc: User.all.pluck(:email),
      # bcc: secret@gmail.com,
      subject: "Your procedure, #{@procedure.title} has been approved by #{@admin.first_name}. Your team can now view it on procedures page."
    )
  end

  def new_procedure
    @email = params[:email]
    @procedure = params[:procedure]
    @admin = params[:admin]
    mails = @email.where(team_id: 1).collect(&:email).join(',')

    mail(
      # from: ENV['EMAIL'],
      # User.where(team_id: 1).collect(&:email).join(",")
      bcc: mails,
      # cc: User.all.pluck(:email),
      # bcc: secret@gmail.com,
      subject: "A new procedure entitled, #{@procedure.title} has been newly added."
    )
  end
end
