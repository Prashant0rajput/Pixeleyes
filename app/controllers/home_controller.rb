class HomeController < ApplicationController


   before_action :authenticate_user , only: [:homepage]

  def authenticate_user

    unless session[:user_id]
      return redirect_to '/'
    end

    current_user = User.find_by(:username => session[:user])

    unless session[:user_id] == current_user.uid

      return redirect_to '/'
    end
      
  end  
  

  def callback

  	 response = Instagram.get_access_token(params[:code] ,:client_secret => 'c3db0dc33041429ca1efef091a1d4490', :client_id=>'238b5101f4fe40b1a3ab8de53d3d0b60', :redirect_uri => 'http://localhost:3000/callback')
     username = response.user.username
  session[:access_token] = response.access_token

  session[:user] = response.user.username
  session[:user_id] = response.user.id

  @user = User.where(:username => username).first_or_create do |user|

    user.name = response.user.full_name
    user.uid  = response.user.id
  end
  # puts session[:user]



  

  
  redirect_to "/homepage"
  	
  end

  def create_user

    puts auth_hash
    
  end


  def logout

    session.clear
    return redirect_to '/'
    
  end



def homepage



url =  "https://api.instagram.com/v1/users/self/media/recent/?access_token=#{session[:access_token]}"

res = RestClient.get url





respond_to do |format|
       format.html{}
       format.json {render :json => res}


  end


end



# def create
#   auth_hash = request.env['omniauth.auth']
 
#   if session[:user_id]
#     # Means our user is signed in. Add the authorization to the user
#     User.find(session[:user_id]).add_provider(auth_hash)
 
#     render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
#   else
#     # Log him in or sign him up
#     auth = Authorization.find_or_create(auth_hash)
 
#     # Create the session
#     session[:user_id] = auth.user.id
 
#     render :text => "Welcome #{auth.user.name}!"
#   end
# end






















end
