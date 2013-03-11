require 'simplecov'

SimpleCov.minimum_coverage 100

SimpleCov.start do
  add_filter '/spec/'
  add_group 'Domain', 'lib/trajectory/domain'
  add_group 'Data Access', 'lib/trajectory/data_access'
  add_group 'Exceptions', 'lib/trajectory/exceptions'
  add_group 'Core Ext', 'lib/trajectory/core_ext'
end
