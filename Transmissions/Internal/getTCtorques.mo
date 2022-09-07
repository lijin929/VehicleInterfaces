within VehicleInterfaces.Transmissions.Internal;
  
function getTCtorques   
  input Real np "Pump speed, rpm"; 
  input Real i "Speed ratio";
  input Real K "Torque ratio";
  input Real lambda "Torque converter capacity"; 
  input Real diameter "Torque converter diameter, m";
  input Real oilDensity=860 "Oil density, kg/m3";
  output Real nt "Turbine speed, rpm";
  output Real Tp "Pump torque, Nm";
  output Real Tt "Turbine torque, Nm";


algorithm
  nt := np * i;
  Tp := oilDensity * 9.8 * lambda * np^2 * diameter^5 / 10^6;
  Tt := Tp * K;
  
end getTCtorques;
