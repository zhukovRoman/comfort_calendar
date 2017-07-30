class ComfortResourcesController < ApplicationController
  # unloadable
  
  menu_item :comfort_calendar_edit, :only => [:edit, :update]
  menu_item :comfort_calendar, :only => :show

  
  before_action :find_optional_project
  
  rescue_from Query::StatementInvalid, :with => :query_statement_invalid
  
  helper :issues
  helper :projects
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  
  def show
    @project = Project.find(params[:project_id])
    if params[:year] and params[:year].to_i > 1900
      @year = params[:year].to_i
      if params[:month] and params[:month].to_i > 0 and params[:month].to_i < 13
        @month = params[:month].to_i
      end
    end
    @year ||= User.current.today.year
    @month ||= User.current.today.month
    
    @calendar = Redmine::Helpers::Calendar.new(Date.civil(@year, @month, 1), current_language, :month)
    retrieve_query
    @query.group_by = nil
    if @query.valid?
      events = []
      events += @query.issues(:include => [:tracker, :assigned_to, :priority],
                              :conditions => ["((start_date BETWEEN ? AND ?) OR (due_date BETWEEN ? AND ?))", @calendar.startdt, @calendar.enddt, @calendar.startdt, @calendar.enddt]
      )
      events += @query.versions(:conditions => ["effective_date BETWEEN ? AND ?", @calendar.startdt, @calendar.enddt])
      
      @calendar.events = events
    end
    
    resources_by_dates = ComfortResource.where('resources_by >= :start_year', start_year: @calendar.startdt)
                             .where('resources_by <= :end_year', end_year: @calendar.enddt)
                             .where(project_id: @project.identifier)

    @resources = {}
    resources_by_dates.each do |resource|
      @resources[resource.resources_by] = resource.resources_count
    end
    
    render :action => 'show', :layout => false if request.xhr?
  end

  def edit
    @project = Project.find(params[:project_id])
    @year = params[:year] || Date.current.year
    @start_date = Date.parse("#{@year}-01-01")
    @start_date = Date.current if @start_date <= Date.current
    @end_date = @start_date.at_end_of_year
    
    @current_date = Date.current
    resources_by_dates = ComfortResource.where('resources_by >= :start_year', start_year: @start_date)
                          .where('resources_by <= :end_year', end_year: @end_date)
                          .where(project_id: @project.identifier)
    
    @resources = {}
    resources_by_dates.each do |resource|
      @resources[resource.resources_by] = resource.resources_count
    end
    
    
  end
  
  def update
    @project = Project.find(params[:project_id])
    ComfortResource.transaction do
      params['resources'].each do |date, value|
        resource = ComfortResource.where(project_id: @project.identifier, resources_by: date).first_or_create
        resource.resources_count = value
        resource.save
      end
    end
    redirect_to({:controller => 'comfort_resources', :action => 'edit', :project_id => params[:project_id] }, notice: 'Ресурсы успешно обновлены!')
  end
  
  
  private
  
  
end
