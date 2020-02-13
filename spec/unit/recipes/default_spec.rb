#
# Cookbook:: python_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'python_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    let(:chef_run) do
     # for a complete list of available platforms and versions see:
     # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
     runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04')
     runner.converge(described_recipe)
   end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'should update all sources' do
      expect(chef_run).to update_apt_update("update")
    end
    it 'should install python3-dev' do
      expect(chef_run).to install_package "python3-dev"
    end
    it 'should install python3-pip' do
      expect(chef_run).to install_package "python3-pip"
    end
    it 'should transfer app files' do
      expect(chef_run).to create_cookbook_file "/home/ubuntu/require/requirements.txt"
    end
    it 'should use pip3 to install packages' do
      expect(chef_run).to run_execute "pip install requirements"
    end
    it 'should create directory Downloads' do
      expect(chef_run).to create_directory "/home/ubuntu/Downloads"
    end
    it 'should create a file ItJobsWatchTop30.csv' do
      expect(chef_run).to create_file "/home/ubuntu/Downloads/ItJobsWatchTop30.csv"
    end
  end

end
