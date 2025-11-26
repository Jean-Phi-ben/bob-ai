class Project < ApplicationRecord
  RATINGS = ["Carpentry", "Electricity", "Plumbing"]
  belongs_to :user

  has_many :messages, dependent: :destroy
  validates :title, presence: true

  STATUSES   = ["ongoing", "finished"].freeze
  CATEGORIES = ["Carpentry", "Electricity", "Plumbing"].freeze
  TOOLS      = ["Hammer", "Screwdriver", "Axe", "Saw", "Drill", "Tape measure"].freeze
  MATERIALS  = ["Screw","Nail","Plywood","Washers","Anchors","Varnish",
                "Pipes","Gaskets","Wires","Switches","Outlets","Light","Cables"].freeze

  # VALIDATIONS DE BASE
  validates :title, presence: true

  # status et category → simples strings
  validates :status, inclusion: { in: STATUSES }, allow_blank: true
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true

  # ON NE FAIT PLUS "validates :tools, inclusion: ..."
  # car tools / materials sont des TABLEAUX
  validate :tools_are_valid
  validate :materials_are_valid


  before_validation :normalize_arrays

  private

  def normalize_arrays
    self.tools ||= []
    self.materials ||= []
    self.tools = tools.reject(&:blank?)
    self.materials = materials.reject(&:blank?)
  end

  def tools_are_valid
    return if tools.blank?
    invalid = tools - CATEGORIES
    if invalid.any?
      errors.add(:categories, "contient des valeurs invalides: #{invalid.join(', ')}")
    end
  end

  def materials_are_valid
    return if materials.blank?
    invalid = materials - MATERIALS
    if invalid.any?
      errors.add(:materials, "contient des valeurs invalides: #{invalid.join(', ')}")
    end
  end
end