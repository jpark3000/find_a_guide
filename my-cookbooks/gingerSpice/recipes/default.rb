# ensure the local APT package cache is up to date
  include_recipe 'apt'
  # install ruby_build tool which we will use to build ruby
  include_recipe 'ruby_build'
  ruby_build_ruby '2.0.0-p353' do
    prefix_path '/usr/local/'
    environment 'CFLAGS' => '-g -O2'
    action :install
  end
  gem_package 'bundler' do
    version '1.6.2'
    gem_binary '/usr/local/bin/gem'
    options '--no-ri --no-rdoc'
  end
  # we create new user that will run our application server
  user_account 'deployer' do
    create_group true
    ssh_keygen false
  end
  # we define our application using application resource provided by application cookbook
  application 'app' do
    owner 'deployer'
    group 'deployer'
    path '/home/deployer/app'
    revision 'chef_demo'
    repository 'git://github.com/concreteinteractive/rails-example-app.git'
    rails do
      bundler true
    end
    unicorn do
      worker_processes 2
    end
  end
