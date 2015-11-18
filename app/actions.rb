helpers do
  def make_vote(status)
    vote = Vote.new(
      track_id: params[:track_id],
      user_id: params[:user_id],
      status: status
    )
    if vote.save
      redirect '/tracks'
    else
      redirect '/tracks?message=Cannot vote for song twice'
    end
  end
end

# Homepage (Root path)
get '/' do
  @user = User.new
  erb :index
end

# Note that each of these are independent of each other as HTTP requests
get '/tracks' do
  @user = User.new
  @tracks = Track.select("tracks.id, tracks.title, tracks.author, tracks.url, SUM(votes.status) AS votes_count").
                 joins("LEFT OUTER JOIN votes ON tracks.id = votes.track_id").
                 group("tracks.id").
                 order("votes_count DESC")
  erb :'tracks/index'
end

get '/tracks/new' do
  @user = User.new
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

post '/reviews' do
  @review = Review.new(
    comment: params[:comment],
    track_id: params[:track_id],
    user_id: params[:user_id]
  )
  if @review.save
    redirect "/tracks/#{@review.track_id}"
  else
    erb :'/tracks/show'
  end
end

get '/tracks/:id' do
  @user = User.new
  @track = Track.find params[:id]
  erb :'/tracks/show'
end

post '/vote_up' do
  make_vote(1)
end

post '/vote_down' do
  make_vote(-1)
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

