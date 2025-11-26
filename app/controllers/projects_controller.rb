class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def create
 index_css

@project = Project.new(project_params)
    @project.user = current_user
      if @project.save
      #TODO: on appelle l'IA avec le prompt du user
      redirect_to project_messages_path(@project), notice: "Project created successfully."

      else
    render :new, status: :unprocessable_entity
    end
  end

  def show
    raise
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:title, :category, :status, :tools, :materials, :methodology, :prompt)
  end
end
