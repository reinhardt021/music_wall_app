# Homepage (Root path)
get '/' do
  erb :index
end


get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end