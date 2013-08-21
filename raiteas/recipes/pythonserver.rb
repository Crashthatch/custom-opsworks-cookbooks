include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application] != 'raiteas_pythonserver'
    Chef::Log.debug("Skipping raiteas::pythonserver for application #{application} as it is not application raiteas_pythonserver")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  opsworks_nodejs do
    deploy_data deploy
    app application
  end
  
  execute "run pip install for #{application}" do
    cwd deploy[:deploy_to]
    command "pip install -r requirements.txt"
    action :run
  end
end
