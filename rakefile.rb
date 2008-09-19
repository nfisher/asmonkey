require 'sprout'
# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

############################################
# Configure your Project Model
project_model :model do |m|
  m.project_name            = 'asmonkey'
  m.language                = 'as3'
  m.background_color        = '#FFFFFF'
  m.width                   = 970
  m.height                  = 550
  # m.src_dir               = 'src'
  # m.lib_dir               = 'lib'
  # m.swc_dir               = 'lib'
  # m.bin_dir               = 'bin'
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  # m.asset_dir             = 'assets'
  # m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  # m.compiler_gem_version  = '>= 4.0.0'
  # m.source_path           << "#{m.lib_dir}/somelib"
  # m.libraries             << :corelib
end


desc 'Compile and debug the application'
debug :debug

desc 'Compile run the test harness'
unit :test

desc 'Compile the optimized deployment'
deploy :deploy

desc 'Create documentation'
asdoc :docs do |t|
	t.source_path << "src"
	t.source_path << "assets"
	t.source_path << "lib/asunit3"
	t.source_path << "test"
	t.doc_sources << "src"
	%w(asmonkeyRunner AllTests ca.function3.functors.HideTest).each { |c| t.exclude_classes << c }
	%w(asunit.framework.Assert asunit.runner.BaseTestRunner asunit.errors.AssertionFailedError asunit.errors.InstanceNotFoundError asunit.textui.ResultPrinter asunit.framework.Test asunit.framework.TestCase asunit.framework.TestFailure asunit.framework.TestListener asunit.framework.TestResult asunit.textui.TestRunner asunit.framework.TestSuite asunit.runner.Version).each { |c| t.exclude_classes << c }
end

desc 'Compile a SWC file'
swc :swc

# set up the default rake task
task :default => :debug
