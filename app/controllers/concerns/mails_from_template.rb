require 'csv'

module MailsFromTemplate
  extend ActiveSupport::Concern

  def build_and_send(substitution_file)
    recipients = []
    sparkpost_data = { recipients: [] }

    CSV.parse(substitution_file.read, headers: :first_row) do |row|
      recipients << row['email']
      sparkpost_data[:recipients] << { substitution_data: row.to_hash }
    end

    ActionMailer::Base.mail(from: "placements@sparkpostbox.com",
                            to: recipients,
                            subject: @mail_template.subject,
                            body: @mail_template.body,
                            sparkpost_data: sparkpost_data
                           ).deliver_later
  end
end
