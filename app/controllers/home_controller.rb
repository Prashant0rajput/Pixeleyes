class HomeController < ApplicationController
  def index
  end

  def callback

  	 response = Instagram.get_access_token(params[:code] ,:client_secret => 'c3db0dc33041429ca1efef091a1d4490', :client_id=>'238b5101f4fe40b1a3ab8de53d3d0b60', :redirect_uri => 'http://localhost:3000/callback')
  session[:access_token] = response.access_token
  session[:user] = response.user.username
  puts session[:user]



  

  
  redirect_to "/homepage"
  	
  end

protected

def homepage

	https://api.instagram.com/v1/users/{user-id}/media/recent/?access_token=ACCESS-TOKEN


end























end