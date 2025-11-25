class Project < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: { in: ["ongoing", "finished",]}
  validates :category, inclusion: { in: ["Carpentry", "Electricity", "Plumbing"]}
  validates :tools, inclusion: { in: ["Hammer", "Screwdriver", "Axe","Saw","Drill","Tape measure"]}
  validates :materials, inclusion: { in: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes","Gaskets","Wires","Switches","Outlets","light"]}

end
