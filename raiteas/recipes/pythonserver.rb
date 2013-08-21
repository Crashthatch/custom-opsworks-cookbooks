include_recipe 'deploy'
include_recipe 'supervisor'

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
    command "pip install requirements.txt"
    action :run
  end
  
  supervisor_service "pythonserver" do
    action :enable
    command "python "+deploy[:deploy_to]+"/app/app.py runserver live"
    numprocs 1
    stdout_logfile "~/python.out"
    stderr_logfile "~/python.err"
    autostart true
    autorestart true
    user "ubuntu"
  end
end
