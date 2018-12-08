require_relative('../models/member.rb')
also_reload('..models/*')

get '/members' do
  @members = Member.all
  erb(:"members/index")
end

get '/members/:id' do
  @member = Member.find(params['id'])
  erb(:"members/show")
end
