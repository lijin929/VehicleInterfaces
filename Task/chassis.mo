within VehicleInterfaces.Task;
model chassis

  parameter Integer rows = 9 "input array rows";
  parameter Integer columns = 9 "input array rows";
  Modelica.Blocks.Interfaces.RealVectorInput ni[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Ti[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput velocity[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput drivingForce[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  parameter Real tyreRadius = 0.34 "Tyre rolling radius, m";
equation 
  velocity = 0.377 * ni * tyreRadius;
  drivingForce = Ti / tyreRadius;

  //for j in 1:columns loop
    //velocity[:,j] = 0.377 * ni[:,j] * tyreRadius;
    //drivingForce[:,j] = Ti[:,j] / tyreRadius;
  //end for;
end chassis;