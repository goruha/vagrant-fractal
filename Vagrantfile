Vagrant.configure("2") do |config|
  p config.fractal.data
  config.vm.define "webserver" do |machine|
    machine.vm.network :private_network, ip: "172.33.10.50"

    machine.vm.provider :virtualbox do |vb, override|
      vb.customize ["modifyvm", :id, "--memory", "256"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      override.vm.box = "centos6.3_x86_64_500g"
      override.vm.box_url = "http://vbox.sciencescape.org/centos6.3_x86_64_500g.box"
    end
  end
end
