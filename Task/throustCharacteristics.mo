within VehicleInterfaces.Task;
model throustCharacteristics

  parameter Integer rows = 9 "input array rows";
  parameter Integer columns = 9 "input array rows";
  Modelica.Blocks.Interfaces.RealVectorInput velocity[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput drivingForce[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput velocity1[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput dynamicFactor[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  parameter Real vehicleMass = 120000 "Vehicle mass, kg";
  parameter Real tyreRadius = 0.34 "Tyre rolling radius, m";
  parameter Real dragCoeffience = 0.8 "Drag force coefficeint";
  parameter Real frontalArea = 4.8 "frontal area, m^2";
  parameter Real airDensity = 1.225 "air density, kg/m^3";
  parameter Real theta = 0 "grade, °";
  //parameter Real rollingCoeffience = 0.008 "rolling risistance coefficeint";

  Real dragForce[rows,columns] "drage force, N";
  Real gradeForce "grade force, N";
  Real normalForce "normal force, N";
  //Real rollingForce "rolling resistance force, N";
  Real longitudinalForce[rows,columns] "longitudinal force, N";
equation 
  dragForce = -0.5 * airDensity * dragCoeffience * frontalArea * velocity .^ 2;
  gradeForce = -vehicleMass * 9.8 * sin(theta);
  normalForce = vehicleMass * 9.8 * cos(theta);
  //rollingForce = -normalForce * rollingCoeffience;
  //longitudinalForce = drivingForce .+ dragForce .+ gradeForce .+ rollingForce;
  longitudinalForce = drivingForce .+ dragForce .+ gradeForce;
  dynamicFactor = longitudinalForce / vehicleMass / 9.8;
  velocity1 = velocity;
end throustCharacteristics;