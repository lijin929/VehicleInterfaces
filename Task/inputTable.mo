within VehicleInterfaces.Task;
model inputTable
  parameter Real array[:,:] = [900, 1903; 1000, 2138; 1100, 2281; 1200, 2282; 1300, 2281; 1500, 2282; 1700, 2041; 1900, 1826; 2050, 0];
  Modelica.Blocks.Interfaces.RealVectorOutput no[size(array, 1)] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput To[size(array, 1)] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Real Po[size(array, 1)] "output power, kW";
equation 
  no = array[:,1];
  To = array[:,2];
  Po = no .* To / 9550;
end inputTable;