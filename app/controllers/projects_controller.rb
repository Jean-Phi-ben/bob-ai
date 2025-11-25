class ProjectsController < ApplicationController
  def create
    @project = Project.find(params[:id])
  end

  def update
  end

  def show
  end
end
