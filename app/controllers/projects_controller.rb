class ProjectsController < ApplicationController
  SYSTEM_PROMPT = <<-PROMPT
  You are an experienced chef, specialised in French gastronomy.

  I am a beginner cook, looking to learn simple recipes.

  Guide me into making a classic French oeuf mayo.

  Provide step-by-step instructions in bullet points, using Markdown.
  PROMPT

  def new
    @project = Project.new # has chat
    @project.user = current_user
  end

  def create
    @project = Project.new(message_params)
    @project.user = current_user

    if @project.save!
      redirect_to project_path(@project)
    else
      render "projects/new"
    end
  end


  def update
  end

  def show
    @project    = current_user.projects.find(params[:id])
    ruby_llm_chat = RubyLLM.project
      response = ruby_llm_chat.with_instructions(instructions).ask(@project.content)
      response = ruby_llm_chat.ask("Help me get started on the following project: #{project.content}")
  end

  def new
    @project = Project.new
  end

  private

  def message_params
  params.require(:project).permit(:title, :prompt, :category, :status, :tools, :processus)
  end

  def instructions
  [SYSTEM_PROMPT, challenge_context].compact.join("\n\n")
  end
end
