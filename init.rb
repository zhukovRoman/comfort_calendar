Redmine::Plugin.register :comfort_calendar do
  name 'Comfort Calendar plugin'
  author 'Zhukov R'
  description 'This is a plugin for PIK-Comfort'
  version '0.0.1'
  url 'pik.ru'
  author_url 'pik.ru'

  permission :comfort_calendar, { :comfort_resources => [:show, :edit, :update] }, :public => false
  menu :project_menu, :comfort_calendar, { :controller => 'comfort_resources', :action => 'show' }, :caption => 'Календарь приёмок', :after => :activity, :param => :project_id
  menu :project_menu, :comfort_calendar_edit, { :controller => 'comfort_resources', :action => 'edit' }, :caption => 'Настроить ресурсы', :after => :comfort_calendar, :param => :project_id

  project_module :comfort_calendar do
    permission :view_comfort_calendar, :comfort_resources => :show
    permission :edit_comfort_resources, :comfort_resources => [:edit, :update]
  end
end
