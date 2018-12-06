require 'erb'
require 'tmpdir'

num_tors = (ENV['NUM_TORS'] || 4).to_i

def render_template(template_path, _binding, output_path)
  erb = ERB.new(File.read(template_path))
  File.write(output_path, erb.result(_binding))
end

tor_port_base = 20000
polipo_port_base = 21000
indicies = 1..num_tors

Dir.mktmpdir(nil, "/root/tmp") { |dir|
  indicies.each { |index|
    tor_port = tor_port_base + index
    data_directory = "#{dir}/tor#{index}"
    tor_config_path = "#{dir}/torrc#{index}" 
    render_template('/root/torrc.erb', binding, tor_config_path)
    spawn("tor -f #{tor_config_path}")
    
    polipo_port = polipo_port_base + index
    polipo_config_path = "#{dir}/config#{index}"    
    render_template('/root/config.erb', binding, polipo_config_path)
    spawn("polipo -c #{polipo_config_path}")
  }
  
  backend_ports = indicies.map { |index|
    polipo_port_base + index
  }    
  haproxy_config_path = "#{dir}/haproxy.cfg"
  render_template('/root/haproxy.cfg.erb', binding, haproxy_config_path)
  spawn("haproxy -f #{haproxy_config_path}")
  
  while true
    sleep 1
  end
}

