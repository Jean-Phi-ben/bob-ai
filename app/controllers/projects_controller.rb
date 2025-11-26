class ProjectsController < ApplicationController
  before_action :authenticate_user!
  def new
    @project = Project.new
    @project.user = current_user
  end

  def index
    @projects = Project.all
  end

  def create

@project = Project.new(project_params)
    @project.user = current_user
      if @project.save
      #TODO: on appelle l'IA avec le prompt du user
      redirect_to project_messages_path(@project), notice: "Project created successfully."

      else
    render :new, status: :unprocessable_entity
>>>>>>> 81f5f40cfa6366b2568ab358b0fbbba80dd7ac8d
    end
  end

  def show
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
