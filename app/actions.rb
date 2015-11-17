# Homepage (Root path)
get '/' do
  @user = User.new
  erb :index
end

# Note that each of these are independent of each other as HTTP requests
get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    title:  params[:title],
    author: params[:author], 
    url:    params[:url],
    user_id: params[:user_id]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'/tracks/show'
end

post '/vote_up' do
  vote = Vote.new(track_id: params[:track_id],user_id: params[:user_id],status: 1)
  if vote.save
    redirect '/tracks'
  else
    redirect '/tracks?message=Cannot vote for song twice'
  end
end

post '/vote_down' do
  vote = Vote.new(track_id: params[:track_id],user_id: params[:user_id],status: -1)
  if vote.save
    redirect '/tracks'
  else
    redirect '/tracks?message=Cannot vote for song twice'
  end
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user
    if user.password == params[:password]
      session[:user_id] = user.id
      session[:user_email] = user.email
      redirect '/tracks'
    else
      redirect '/login?message=Invalid password'  
    end
  else
    redirect '/login?message=Invalid email'
  end
end

post '/logout' do
  session.clear
  session[:user_id] = nil
  redirect '/'
end

post '/signup' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    session[:user_email] = @user.email
    redirect '/tracks'
  else
    erb :'index'
  end

end

