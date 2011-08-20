# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#
guard 'rspec', :version => 2, :cli => "--colour" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/fabricators/.+_fabricator\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec/" }
  watch('boggle.rb')  { "root/" }

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec/" }
  watch('spec/spec_helper.rb')                        { "spec/" }
end
