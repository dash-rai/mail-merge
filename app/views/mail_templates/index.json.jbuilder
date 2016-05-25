json.array!(@mail_templates) do |mail_template|
  json.extract! mail_template, :id, :from, :to, :subject, :user_id
  json.url mail_template_url(mail_template, format: :json)
end
