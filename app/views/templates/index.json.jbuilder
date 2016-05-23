json.array!(@templates) do |template|
  json.extract! template, :id, :from, :to, :subject, :body, :user_id
  json.url template_url(template, format: :json)
end
