ruby supervisor_service "pythonserver" do
  command "python /srv/www/raiteas_pythonserver/current/app/app.py runserver live"
  numprocs 1
  stdout_logfile "~/python.out"
  stderr_logfile "~/python.err"
  autostart true
  autorestart true
  user "ubuntu"
  action :enable
end