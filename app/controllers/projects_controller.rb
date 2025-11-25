class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  def index
    @projects = Project.all
  end

  def create
     @project = Project.new(project_params)
  if @project.save!
    raise
    render :create
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
