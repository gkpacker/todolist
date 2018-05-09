class TaskListPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  attr_reader :task_list

  def initialize(task_list, current_user)
    @task_list = task_list
    @current_user = current_user
    __setobj__(task_list)
  end

  def eql?(target)
    target == self || task_list.eql?(target)
  end

  def edit
    helpers.content_tag(:td, helpers.link_to(
      '<span class="glyphicon glyphicon-edit" style="font-size: 30px;"></span>'.html_safe,
      route(edit_task_list_path(@task_list)))) if @task_list.user == @current_user
  end

  def task_links
    @task_list.user == @current_user ? 'owned_task' : 'not_owned_task'
  end

  private

  def helpers
    ApplicationController.helpers
  end

  def route(path)
    Rails.application.routes.recognize_path(path)[:controller]
  end
end
