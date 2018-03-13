# 
# class User
#
#   def value(key)
#     if @user
#       @user["user"][key]
#     else
#       p "No active session."
#     end
#   end
#
#   def get_user
#     @user = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => Session.auth_token })
#   end
# end
