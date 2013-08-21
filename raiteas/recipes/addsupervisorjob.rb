include_recipe 'supervisor'
  
supervisor_service "pythonserver" do
  action :enable
  command "python "+deploy[:deploy_to]+"/app/app.py runserver live"
end