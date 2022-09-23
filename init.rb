Redmine::Plugin.register :redmine_progress_manage do
  name 'Redmine Progress Manage plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  menu :account_menu, :progress_manage_index, { :controller => 'progress_manage', :action => 'index' }, :caption => '進捗管理', :before => :logout, :if => Proc.new{User.current.logged?}
end
