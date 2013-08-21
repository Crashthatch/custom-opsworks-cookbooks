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