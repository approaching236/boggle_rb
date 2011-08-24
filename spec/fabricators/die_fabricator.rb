Fabricator(:die) do
  face { rand(6) }
  on_init { init_with(Array.new(6) { (rand(122-97) + 97).chr }) }
end
