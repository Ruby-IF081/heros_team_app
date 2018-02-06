every :day, at: '10am', roles: [:web] do
  rake "superadmin_user_creation_notifications:send"
end
