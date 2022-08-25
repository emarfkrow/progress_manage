# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get  'progress_manage',               :to => 'progress_manage#index'
get  'progress_manage/holidays',      :to => 'progress_manage#holidays'
get  'progress_manage/statuses',      :to => 'progress_manage#statuses'
get  'progress_manage/users',         :to => 'progress_manage#users'
get  'progress_manage/search',        :to => 'progress_manage#search'
post 'progress_manage/setHolidays',   :to => 'progress_manage#setHolidays'
post 'progress_manage/putIssue',      :to => 'progress_manage#putIssue'
post 'progress_manage/putActualPlan', :to => 'progress_manage#putActualPlan'
