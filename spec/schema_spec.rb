# frozen_string_literal: true

require_relative '../bin/schema'

RSpec.shared_examples 'shared tests' do |values|
  let(:args) { values }

  it do
    schema = Schema.new
    statement = args[:statement].split
    expect(schema.unpack_values(statement)).to eq(args[:expected_values])
  end

end

RSpec.describe Schema do
  context 'register valid flags in array' do
    include_examples 'shared tests', { statement: '-l -p 8080 -d /bin/var', expected_values: [['-l', 'logging', TrueClass], ['-p', 'port', Integer, 8080], ['-d', 'directory', String, '/bin/var']]}
  end

  context 'register last flag if not value is passed' do
    include_examples 'shared tests', { statement: '-p 8080 -l', expected_values: [['-p', 'port', Integer, 8080], ['-l', 'logging', TrueClass]]}
  end

  context 'register only the valid flag' do
    include_examples 'shared tests', { statement: '-l -d', expected_values: [['-l', 'logging', TrueClass], ['-d', 'directory', String]]}
  end

  context 'show error if two values are entered' do
    include_examples 'shared tests', { statement: '-p 8080 60', expected_values: 'Invalid flag: 60'}
  end

  context 'show error if invalid flag' do
    include_examples 'shared tests', { statement: '-p 8080 -yy', expected_values: 'Invalid flag: -yy'}
  end

  context 'accept negative numbers' do
    include_examples 'shared tests', { statement: '-l -p -68 -d /usr/bin', expected_values: [['-l', 'logging', TrueClass], ['-p', 'port', Integer, -68], ['-d', 'directory', String, '/usr/bin']]}
  end
end
