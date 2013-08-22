include_recipe 'supervisor'
  
supervisor_service "pythonserver" do
  directory "/srv/www/raiteas_pythonserver/current/app"
  command "python app.py runserver live"
  numprocs 1
  stdout_logfile "/home/ubuntu/python.out"
  stderr_logfile "/home/ubuntu/python.err"
  autostart true
  autorestart true
  user "ubuntu"
  action [:enable, :start]
end