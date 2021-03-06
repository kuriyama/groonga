#!/usr/bin/env ruby

if ARGV.size != 4
  puts("Usage: #{$0} BUILD_COFNIG.RB MRUBY_SOURCE_DIR MRUBY_BUILD_DIR TIMESTAMP_FILE")
  exit(false)
end

require "rbconfig"
require "fileutils"

build_config_rb = File.expand_path(ARGV.shift)
mruby_source_dir = ARGV.shift
mruby_build_dir = File.expand_path(ARGV.shift)
timestamp_file = File.expand_path(ARGV.shift)

FileUtils.rm_rf(mruby_build_dir)

Dir.chdir(mruby_source_dir) do
  unless system(RbConfig.ruby,
                "minirake",
                "MRUBY_CONFIG=#{build_config_rb}",
                "MRUBY_BUILD_DIR=#{mruby_build_dir}")
    exit(false)
  end
end

FileUtils.touch(timestamp_file)

FileUtils.cp("#{mruby_build_dir}/host/src/y.tab.c", "parse.c")
FileUtils.cp("#{mruby_build_dir}/host/mrblib/mrblib.c", "./")

File.open("mrbgems_init.c", "w") do |mrbgems_init|
  Dir.glob("#{mruby_build_dir}/host/mrbgems/**/gem_init.c") do |gem_init|
    mrbgems_init.puts(File.read(gem_init))
  end
end

mruby_onig_regexp_dir = "#{mruby_build_dir}/mrbgems/mruby-onig-regexp"
FileUtils.mkdir_p("mruby-onig-regexp/")
FileUtils.cp_r("#{mruby_onig_regexp_dir}/src/", "mruby-onig-regexp/")

mruby_io_dir = "#{mruby_build_dir}/mrbgems/mruby-io"
FileUtils.mkdir_p("mruby-io/")
FileUtils.cp_r("#{mruby_io_dir}/include/", "mruby-io/")
FileUtils.cp_r("#{mruby_io_dir}/src/", "mruby-io/")
