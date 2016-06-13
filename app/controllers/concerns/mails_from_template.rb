require 'csv'

module MailsFromTemplate
  extend ActiveSupport::Concern

  def build_and_send_mails(substitution_file)
    CSV.parse(substitution_file.read, headers: :first_row) do |row|
      template = Liquid::Template.parse(@mail_template.body)
      body = template.render(row.to_hash)

      ActionMailer::Base.mail(from: "placements@sparkpostbox.com",
                              to: row['email'],
                              subject: @mail_template.subject,
                              body: body
                             ).deliver_later
    end
  end
end
