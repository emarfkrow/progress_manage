# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'progress_manage',          :to => 'progress_manage#index'
get 'progress_manage/holidays', :to => 'progress_manage#holidays'
get 'progress_manage/statuses', :to => 'progress_manage#statuses'
get 'progress_manage/users',    :to => 'progress_manage#users'
get 'progress_manage/search',   :to => 'progress_manage#search'
