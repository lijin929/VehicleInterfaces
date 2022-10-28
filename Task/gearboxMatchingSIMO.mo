within VehicleInterfaces.Task;
model gearboxMatchingSIMO

  parameter Integer columns = 9 "input array columns";
  Modelica.Blocks.Interfaces.RealVectorInput ni[columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Ti[columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput no[size(gearboxTable, 1),columns] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput To[size(gearboxTable, 1),columns] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //parameter Real inputTable[:,2] = [0,3964; 829,3015; 1041,2728; 1270,2390; 1401,2215; 1536,2024; 1691,1769; 1810,1567; 1902,1391; 2137,1045] "speed and torque input array";
  parameter Real gearboxTable[:,2] = [4.630, 0.9; 3.400, 0.9; 2.190, 0.9; 1.520, 0.9; 1.000, 0.9; 0.760, 0.9; 0.670, 0.9] "gearbox ratio and effience";
  //Real no[size(inputTable, 1),size(gearboxTable, 1)] "output speed array, rpm";
  //Real To[size(inputTable, 1),size(gearboxTable, 1)] "output torque array, Nm";
  Real Pi[columns] "input power, kW";
  Real Po[size(no, 1),size(no, 2)] "output power, kW";
  Real powerLoss[size(no, 1),size(no, 2)] "power loss, kW";
equation 
  Pi = ni .* Ti / 9550;
  for i in 1:size(gearboxTable, 1) loop 
    no[i,:] = ni / gearboxTable[i,1];
    To[i,:] = Ti * gearboxTable[i,1] * gearboxTable[i,2];
    Po[i,:] = Pi * gearboxTable[i,2];
    powerLoss[i,:] = Pi * (1 - gearboxTable[i,2]);
  end for;
end gearboxMatchingSIMO;