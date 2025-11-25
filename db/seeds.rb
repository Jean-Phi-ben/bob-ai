puts "Cleaning database..."
Project.destroy_all
User.destroy_all

puts "Creating users..."
henry = User.create!(
  first_name: "Henry",
  last_name: "Thiery",
  email: "henry@mail.com",
  password: "secret",
)

puts "Creating projects..."
methodology = <<~METHODO
  Cut the wood boards to the desired dimensions for the tabletop and legs.

  Sand all pieces to remove rough edges and prepare for assembly.

  Assemble the tabletop by joining the boards with wood glue and clamps.

  Attach cross-supports underneath to strengthen the structure.

  Build the legs using simple straight cuts or premade wooden legs.

  Secure the legs to the tabletop frame using screws and wood glue.

  Check that the table is level and adjust if necessary.

  Fill holes or gaps with wood filler and let it dry.

  Sand again for a smooth finish before applying stain or paint.

  Apply varnish or protective finish and let it fully dry.

  METHODO

project_2 = Project.create!(
  title: "Installing light on a load-bearing wall.",
  category: "Electricity",
  status: "ongoing", #en cours
  tools: ["Drill", "Screwdriver", "Tape measure"],
  materials: ["Light", "Screw", "Anchors", "Cables"],
  methodology: methodology,
  user: henry,
  created_at: "2025-11-01",
)
project_3 = Project.create!(
  title: "Racking chair",
  category: "Carpentry",
  status: "ongoing", #en cours
  tools: ["Screwdriver", "Saw", "Tape measure", "Hammer"],
  materials: ["Screw", "Nail", "Plywood", "Anchors"],
  methodology: methodology,
  user: henry,
  created_at: "2024-03-11",
)

puts "Finished!"
