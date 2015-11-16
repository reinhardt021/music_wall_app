# Homepage (Root path)
get '/' do
  erb :index
end


get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  erb :'tracks/new'
end

post '/tracks' do
  @tracks = Track.new(
    title:  params[:title],
    author: params[:author], 
    url:    params[:url]
  )
  if @tracks.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'/tracks/show'
end