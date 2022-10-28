within VehicleInterfaces.Task;
model gearboxMatchingMIMO

  parameter Integer rows = 9 "input array rows";
  parameter Integer columns = 9 "input array columns";
  Modelica.Blocks.Interfaces.RealVectorInput ni[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Ti[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput no[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput To[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  parameter Real gearboxTable[2] = {1.0, 1.0} "gearbox ratio and effience";
  Real Pi[size(ni, 1),size(ni, 2)] "input power, kW";
  Real Po[size(no, 1),size(no, 2)] "output power, kW";
  Real powerLoss[size(no, 1),size(no, 2)] "power loss, kW";
equation 
  Pi = ni .* Ti / 9550;
  no = ni / gearboxTable[1];
  To = Ti * gearboxTable[1] * gearboxTable[2];
  Po = Pi * gearboxTable[2];
  powerLoss = Pi * (1 - gearboxTable[2]);

  //for j in 1:columns loop
    //Pi[:,j] = ni[:,j] .* Ti[:,j] / 9550;
    //no[:,j] = ni[:,j] / gearboxTable[1];
    //To[:,j] = Ti[:,j] * gearboxTable[1] * gearboxTable[2];
    //Po[:,j] = Pi[:,j]*gearboxTable[2];
    //powerLoss[:,j] = Pi[:,j]*(1-gearboxTable[2]);
  //end for;
end gearboxMatchingMIMO;