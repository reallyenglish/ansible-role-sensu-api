require "spec_helper"
require "serverspec"

package = "sensu-api"
service = "sensu-api"
config_dir = "/etc/sensu"
user    = "sensu"
group   = "sensu"
ports = [4242]
default_user = "root"
default_group = "root"

case os[:family]
when "freebsd"
  config_dir = "/usr/local/etc/sensu"
  default_group = "wheel"
  package = "sensu"
end
config = "#{config_dir}/config.json"

describe package(package) do
  it { should be_installed }
end

case os[:family]
when "freebsd"
  describe file("/usr/local/etc/rc.d/sensu-api") do
    it { should exist }
    it { should be_file }
    it { should be_mode 755 }
    its(:content) { should_not match(/sensu_client/) }
  end
end

[
  "plugins",
  "extensions",
  "conf.d"
].each do |d|
  describe file("#{config_dir}/#{d}") do
    it { should exist }
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by user }
    it { should be_grouped_into group }
  end
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  # XXX currently, it is an empty json
  # its(:content) { should match Regexp.escape("sensu-api") }
end

describe file("#{config_dir}/conf.d/transport.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content_as_json) { should include("transport" => include("name" => "rabbitmq")) }
  its(:content_as_json) { should include("transport" => include("reconnect_on_error" => true)) }
end

describe file("#{config_dir}/conf.d/api.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content_as_json) { should include("api" => include("host" => "10.0.2.15")) }
  its(:content_as_json) { should include("api" => include("bind" => "10.0.2.15")) }
  its(:content_as_json) { should include("api" => include("port" => 4242)) }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
