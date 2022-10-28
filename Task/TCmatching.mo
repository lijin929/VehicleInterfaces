within VehicleInterfaces.Task;
model TCmatching

  parameter Integer columns = 9 "input array columns";
  Modelica.Blocks.Interfaces.RealVectorInput ni[columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Ti[columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput no[size(lambdaTable, 1)] annotation (
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput To[size(lambdaTable, 1)] annotation (
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //parameter Real engine[:, 2] = [900, 1903; 1000, 2138; 1100, 2281; 1200, 2282; 1300, 2281; 1500, 2282; 1700, 2041; 1900, 1826; 2050,0] "Pump speed, rpm";
  parameter Real diameter = 0.43 "TC diameter, m";
  parameter Real oilDensity = 860 "Oil density, kg/m3";
  parameter Real lambdaTable[:,4] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016] "torque converter λ parameters";
  Real Tp[size(lambdaTable, 1),columns] "Pump torque, Nm";
  Real npCowork[size(lambdaTable, 1)] "Pump speed at cowork, rpm";
  Real TpCowork[size(lambdaTable, 1)] "Pump torque at cowork, Nm";
  //Real ntCowork[size(lambdaTable, 1)] "turnbine speed at cowork, rpm";
  //Real TtCowork[size(lambdaTable, 1)] "turbine torque at cowork, Nm";
  Real Pi[columns] "input power, kW";
  Real Po[size(no, 1)] "output power, kW";
  Real powerLoss[size(no, 1)] "power loss, kW";
equation 
  for i in 1:size(lambdaTable, 1) loop 
    Tp[i] = oilDensity * 9.8 * lambdaTable[i,4] * ni .^ 2 * diameter ^ 5 / 10 ^ 6;
    npCowork[i] = Blocks.InterpolateVector(0, [Tp[i] - Ti, ni]);
  end for;
  //ntCowork[j] = npCowork[j] * lambdaTable[j, 1];
  no = npCowork .* lambdaTable[:,1];
  TpCowork = oilDensity * 9.8 * lambdaTable[:,4] .* npCowork .^ 2 * diameter ^ 5 / 10 ^ 6;
  //TtCowork[j] = TpCowork[j] * lambdaTable[j, 2];
  To = TpCowork .* lambdaTable[:,2];
  Pi = ni .* Ti / 9550;
  Po = no .* To / 9550;
  powerLoss = npCowork .* TpCowork / 9550 - Po;
end TCmatching;
