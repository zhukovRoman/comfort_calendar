# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get 'comfort_resources', :to => 'comfort_resources#show'
get 'comfort_resources/edit', :to => 'comfort_resources#edit'
post 'comfort_resources/update', :to => 'comfort_resources#update'
