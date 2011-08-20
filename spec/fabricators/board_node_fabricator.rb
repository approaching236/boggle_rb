Fabricator(:board_node) do
  die { Fabricate(:die) }
  position { rand(6) }
end
