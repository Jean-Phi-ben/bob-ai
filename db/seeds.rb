puts "cleaning database ..."
Project.destroy_all
User.destroy_all

puts "create a new user ...."
henry = User.create!(
  first_name: "Henry",
  last_name: "Thierry",
  email: "henry@mail.com",
  password: "secret",
)

puts "create a project .... "
methodology = <<~METHODO
  TODO: ici rediger en markdown un process finalisé
METHODO

project_1 = Project.create!(
  title: "bedside table",
  category: "Carpentry",
  status: "ongoing",
  tools: ["Hammer", "Screwdriver", "Axe","Saw","Tape measure"],
  materials: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes"],
  methodology: methodology,
  user: henry,
  created_at: "2025-11-01",
)

project_4 = Project.create!(
  title: "rainwater harvesting",
  category: "Plumbing",
  status: "finished",
  tools: ["Hammer", "Screwdriver", "Axe","Saw","Tape measure"],
  materials: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes"],
  methodology: methodology,
  user: henry,
  created_at: "2024-03-12",
)

project_5 = Project.create!(
  title: "garden light path",
  category: "Electricity",
  status: "finished",
  tools: ["Hammer", "Screwdriver", "Axe","Saw","Tape measure"],
  materials: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes"],
  methodology: methodology,
  user: henry,
  created_at: "2025-06-12",
  )

project_ = Project.create!(
  title: "bar counter",
  category: "Carpentry",
  status: "finished",
  tools: ["Hammer", "Screwdriver", "Axe","Saw","Tape measure"],
  materials: ["Screw","Nail","Plywood","Washers","Anchors","Varnish","Pipes"],
  methodology: methodology,
  user: henry,
  created_at: "2023-02-29",
  )

  puts " i finished all ..."
