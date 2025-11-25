class Project < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user

  has_many :messages, dependent: :destroy
  validates :title, presence: true
=======
  #RATINGS = ['carpentry', 'electricity', 'plumbing']
    belongs_to :user
>>>>>>> 451d38750b50360cb9bfe84ca9ae8a6a003ccc67


  has_many :messages, dependent: :destroy
  validates :title, presence: true
  validates :status, inclusion: { in: ["ongoing", "finished",]}
  #validates :category, collection: { in: ["Carpentry", "Electricity", "Plumbing"]}
  validates :tools, inclusion: { in: ["Hammer", "Screwdriver", "Axe","Saw","Drill","Tape measure"]}
  validates :materials, inclusion: { in: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes","Gaskets","Wires","Switches","Outlets","Light", "Cables"]}

end
