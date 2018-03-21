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

def stats
  
end

def homepage



url_1 =  "https://api.instagram.com/v1/users/self/media/recent/?access_token=#{session[:access_token]}"

@res_1 = RestClient.get url_1

url_2 = "https://api.instagram.com/v1/users/self/followed-by?access_token=#{session[:access_token]}"

@res_2 = RestClient.get url_2

url_3 = "https://api.instagram.com/v1/users/self/follows?access_token=#{session[:access_token]}"

@res_3 = RestClient.get url_3





# :res_1 => res_1 , :res_2 => res_2

respond_to do |format|
       format.html{}
       format.json {render :json => {:res_1 => @res_1 , :res_2 => @res_2}, :res_3 => @res_3}
       

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
