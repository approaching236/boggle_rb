Fabricator(:die) do
  face { rand(6) }
  letters { Array.new(6) { (rand(122-97) + 97).chr } }
end
