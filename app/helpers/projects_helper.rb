module ProjectsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_projects_path
    elsif action_name == 'edit'
      project_path
    end
  end
end
