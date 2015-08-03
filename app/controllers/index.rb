def current_user
  if session[:user_id]
    User.find session[:user_id]
  else
    nil
  end
end

def logged_in?
    if current_user
      true
    else
      false
    end
  end



get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/users/login' do

  @user = User.authenticate(params["email"], params["password"])
# @user = User.create(email: params["email"], password: params["password"])

  if @user
    session[:user_id] = @user.id
    redirect "/create"
  else
    redirect "/"
  end
end

get '/create' do
   erb :entry_post
end

post '/create' do
  @user = current_user
  if logged_in?
    @post = Post.create(text: params[:post][:text], title: params[:post][:title])
    redirect "/view/#{@user.id}"


  else
    redirect "/"
  end
end

get '/view' do
 @post = Post.all
  erb :view
end

get '/view/:u_id' do


  @post = Post.find_by(id: params[:u_id])
  @tags = @post.posts
  erb :view

end

put 'view/:id' do

  @post = Post.find(id: params[:id])
  @update = @post.update(params[:post][:body])

  redirect "/view/:u_id"



end

get '/join_us' do
  erb :join_us
end

post '/join_us' do
  @user = User.new(email: params[:input][:email], password: params[:input][:password], name: params[:input][:name])
  if @user.save
    session[:sign_up] = @user.id
    redirect "/view"
  else
    redirect '/join_us'
  end
end

get '/view' do
  @posts = Post.all
  @tags = Tag.all
  erb :view
end

# get '/view/:p_id' do

# end


get '/view/tags/:t_id' do

end

delete 'view/:id/delete' do
  @post = Post.find(params[:id])
  byebug
  @delete = @post.destroy

  redirect "/view"
end

post '/logout' do
  redirect '/'
end


# delete '/logout' do
#   session[:user_id] = nil
#   redirect "/"

# end