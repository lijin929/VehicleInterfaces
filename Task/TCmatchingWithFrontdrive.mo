within VehicleInterfaces.Task;
model TCmatchingWithFrontdrive
  //parameter Real engine[:, 2] = [900, 1903; 1000, 2138; 1100, 2281; 1200, 2282; 1300, 2281; 1500, 2282; 1700, 2041; 1900, 1826; 2050,0] "Pump speed, rpm";  
  parameter Real frontDrive[2] = {1.0, 1.0} "Front drive ratio and effience";
  parameter Real diameter = 0.43 "TC diameter, m";
  parameter Real oilDensity = 860 "Oil density, kg/m3";
  parameter Real lambdaTable[:,4] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016] "torque converter λ parameters";
  Real tcInput[size(u, 1),size(u, 2)] "Pump speed, rpm";
  Real Tp[size(tcInput, 1),size(lambdaTable, 1)] "Pump torque, Nm";
  Real npCowork[size(lambdaTable, 1)] "Pump speed at cowork, rpm";
  Real TpCowork[size(lambdaTable, 1)] "Pump torque at cowork, Nm";
  //Real ntCowork[size(lambdaTable, 1)] "turnbine speed at cowork, rpm";
  //Real TtCowork[size(lambdaTable, 1)] "turbine torque at cowork, Nm";


  parameter Real rows = 9 "input array rows";
  Modelica.Blocks.Interfaces.RealVectorInput u[9,2] annotation (
    Placement(visible = true, transformation(origin = {-100, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorOutput y[size(lambdaTable, 1),2] annotation (
    Placement(visible = true, transformation(origin = {100, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation 
  tcInput = [u[:,1] / frontDrive[1], u[:,2] * frontDrive[1] * frontDrive[2]];
  for j in 1:size(lambdaTable, 1) loop 
    Tp[:,j] = oilDensity * 9.8 * lambdaTable[j,4] * tcInput[:,1] .^ 2 * diameter ^ 5 / 10 ^ 6;
    npCowork[j] = Blocks.InterpolateVector(0, [Tp[:,j] - tcInput[:,2], tcInput[:,1]]);
    //ntCowork[j] = npCowork[j] * lambdaTable[j, 1];
    y[j,1] = npCowork[j] * lambdaTable[j,1];
    TpCowork[j] = oilDensity * 9.8 * lambdaTable[j,4] * npCowork[j] ^ 2 * diameter ^ 5 / 10 ^ 6;
    //TtCowork[j] = TpCowork[j] * lambdaTable[j, 2];
    y[j,2] = TpCowork[j] * lambdaTable[j,2];
  end for;
end TCmatchingWithFrontdrive;
