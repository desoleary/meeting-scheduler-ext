# frozen_string_literal: true

require 'pathname'
require 'date'
require 'rspec/core'

require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object/blank'
require 'rordash'

# Sets up environment for running specs and via irb e.g. `$ irb -r ./dev/setup`

%w[../../lib/meeting_scheduler ../../spec/spec_helper].each do |rel_path|
  require File.expand_path(rel_path, Pathname.new(__FILE__).realpath)
end
