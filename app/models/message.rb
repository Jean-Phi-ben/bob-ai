class Message < ApplicationRecord
  belongs_to :project
  validates :content, presence: true
  after_create_commit :broadcast_append_to_project

  private

  def broadcast_append_to_project
    broadcast_append_to project, target: "messages", partial: "messages/message", locals: { message: self }
  end

end
