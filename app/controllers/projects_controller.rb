class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def index
    @ongoing_projects  = current_user.projects.where(status: "ongoing")
    @finished_projects = current_user.projects.where(status: "finished")
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project

    if @project.save
      redirect_to project_messages_path(@project), notice: "Project created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find(params[:id])
    
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :category,
      :status,
      :prompt,
      tools: [],      # 👈 array
      materials: []
    )
  end
end
