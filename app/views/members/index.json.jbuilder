json.array!(@members) do |member|
  json.extract! member, :id, :member_id, :email, :bday, :occupation
  json.url member_url(member, format: :json)
end
