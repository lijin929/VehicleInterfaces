within VehicleInterfaces.Transmissions;

model TC_lambda
  //extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(
    Placement(visible = true, transformation(origin = {-98, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(
    Placement(visible = true, transformation(origin = {100, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  parameter Modelica.Units.SI.Length diameter = 0.43;
  parameter Modelica.Units.SI.Density oilDensity = 860;  
  parameter Real LambdaTable[:,:] = [0, 1.93, 0, 6.23; 0.1, 1.89, 19, 6.34; 0.2, 1.8, 36, 6.42; 0.3, 1.71, 51, 6.48; 0.40, 1.58, 63, 6.5; 0.50, 1.43, 72, 6.395; 0.60, 1.35, 81, 5.636; 0.65, 1.27, 83, 5.401; 0.7, 1.23, 86, 4.951; 0.75, 1.17, 88, 4.547; 0.8, 1.12, 89, 4.117; 0.85, 1.05, 89, 3.686; 0.86, 1.05, 90, 3.616; 0.89, 1, 89, 3.208; 0.9, 1, 90, 3.059; 0.95, 1, 95, 1.733; 1, 1, 100, 0.016] "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])";  
  
  Real i "speed ratio";
  Real K "torque ratio";
  //type TCCapacity = Real(unit = "min2/(m.rev2)", min = 0);
  Real lambda(unit = "min2/(m.rev2)", min = 0) "TC capacity";
  Real n_a(unit="rev/min") "flange_a.w to rpm";
  Real n_b(unit="rev/min") "flange_b.w to rpm";
  Modelica.Blocks.Tables.CombiTable1Dv combiTable1Dv(table = LambdaTable)  annotation(
    Placement(visible = true, transformation(origin = {-6, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
protected 
  Modelica.Units.SI.Angle phi_a; 
  Modelica.Units.SI.AngularVelocity w_a;
  Modelica.Units.SI.Angle phi_b; 
  Modelica.Units.SI.AngularVelocity w_b;
  
  
equation
  phi_a = flange_a.phi;
  phi_b = flange_b.phi;
  w_a = der(phi_a);  
  w_b = der(phi_b);
  n_a = Modelica.Units.Conversions.to_rpm(w_a);
  n_b = Modelica.Units.Conversions.to_rpm(w_b);
  i = w_b / w_a;
  combiTable1Dv.u = {i,i,i};
  K = combiTable1Dv.y[1];
  lambda = combiTable1Dv.y[3];
  flange_a.tau = oilDensity * 9.8 * lambda * n_a ^ 2 * diameter ^ 5 * 10^(-6);
  flange_b.tau + K * flange_a.tau = 0;
  


annotation(
    Icon(graphics = {Rectangle(origin = {5, 3}, extent = {{-63, 59}, {63, -59}}), Text(origin = {4, -1}, extent = {{-44, 39}, {44, -39}}, textString = "λ", fontName = "Times New Roman")}));
end TC_lambda;
