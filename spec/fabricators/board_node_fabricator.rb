Fabricator(:board_node) do
  on_init { init_with(Array.new(6) { (rand(122-97) + 97).chr }.join.upcase) }
end
