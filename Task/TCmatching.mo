within VehicleInterfaces.Task;

model TCmatching
  parameter Real np[:, :] = [900, 1903; 1000, 2138; 1100, 2281; 1200, 2282; 1300, 2281; 1500, 2282; 1700, 2041; 1900, 1826; 2050,0] "Pump speed, rpm";
  parameter Modelica.Units.SI.Length diameter = 0.43 "TC diameter, m";
  parameter Modelica.Units.SI.Density oilDensity = 860 "Oil density, kg/m3";
  parameter Real table[:, :] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016];
  Real Tp[size(table, 1), size(np, 1)] "Pump torque, Nm";
  Real npCowork[size(table, 1)] "Pump speed at cowork, rpm";
  Real TpCowork[size(table, 1)] "Pump torque at cowork, Nm";
  Real ntCowork[size(table, 1)] "turnbine speed at cowork, rpm";
  Real TtCowork[size(table, 1)] "turbine torque at cowork, Nm";
equation
  for j in 1:size(table, 1) loop
    Tp[j, :] = oilDensity * 9.8 * table[j, 4] * np[:, 1] .^ 2 * diameter ^ 5 / 10 ^ 6;
    npCowork[j] = Blocks.InterpolateVector(0, [Tp[j, :]-np[:, 2], np[:, 1]]);
    ntCowork[j] = npCowork[j] * table[j, 1];
    TpCowork[j] = oilDensity * 9.8 * table[j, 4] * npCowork[j]^ 2 * diameter ^ 5 / 10 ^ 6;
    TtCowork[j] = TpCowork[j] * table[j, 2];
  end for;
  
end TCmatching;
