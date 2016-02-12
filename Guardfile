guard :rspec, cmd: 'bundle exec rspec --color --format documentation' do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
end

notification :off
