class Project < ApplicationRecord
  #RATINGS = ['carpentry', 'electricity', 'plumbing']
    belongs_to :user


  has_many :messages, dependent: :destroy
  validates :title, presence: true
  validates :status, inclusion: { in: ["ongoing", "finished",]}
  #validates :category, collection: { in: ["Carpentry", "Electricity", "Plumbing"]}
  validates :tools, inclusion: { in: ["Hammer", "Screwdriver", "Axe","Saw","Drill","Tape measure"]}
  validates :materials, inclusion: { in: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes","Gaskets","Wires","Switches","Outlets","Light", "Cables"]}

end
