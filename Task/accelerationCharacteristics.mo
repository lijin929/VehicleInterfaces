within VehicleInterfaces.Task;
model accelerationCharacteristics


  parameter Integer rows = 3 "input array rows";
  parameter Integer columns = 8 "input array columns";
  parameter Real phi = 0.7 "";
  parameter Real rollingCoeffience = 0.016 "";
  parameter Real d[3,rows] = [
    0.0310, 0.0360, 0.0440; 
    0.4000, 0.4000, 0.4000; 
    1.2000, 1.1000, 1.0800] "";

//   Real velocity[rows,columns] = [
//     0, 9.04, 15.50, 21.93, 22.99, 24.35, 27.39, 30.44; 
//     30.44, 31.15, 32.57, 34.50, 36.26, 38.81, 41.16, 43.12; 
//     43.12, 45.97, 46.98, 48.64, 51.12, 54.71, 58.03, 60.79];


//   Real dynamicFactor[rows,columns] = [
//     0.418, 0.328, 0.266, 0.210, 0.200, 0.193, 0.179, 0.160; 
//     0.139, 0.137, 0.130, 0.124, 0.120, 0.114, 0.107, 0.099; 
//     0.086, 0.079, 0.077, 0.074, 0.069, 0.064, 0.057, 0.052];

  Modelica.Blocks.Interfaces.RealVectorInput velocity[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput dynamicFactor[rows,columns] annotation (
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Real t[rows,columns + 1];
  Real v[rows,columns + 1];
  Real s[rows,columns + 1];
protected 
  Real fdh;
  Real fdk;
  Real vh;
  Real vk;
  Real ah;
  Real ak;
  Real as;
  Real dt;
  Real ds;
  Real dv;
  Real t0;
  Real s0;
  Real v0;
algorithm 
    
  t0 := 0;
  s0 := 0;
  v0 := 0; 
  for i in 1:rows loop
    if i > 1 then
      v0 := velocity[i, 1];
    end if;
    for j in 1:columns-1 loop
      fdh := min(dynamicFactor[i, j], phi);
      fdk := min(dynamicFactor[i, j + 1], phi);
      vh := velocity[i, j] / 3.6;
      vk := velocity[i, j + 1] / 3.6;
      ah := 9.8 * (fdh - rollingCoeffience) / d[3, i];
      ak := 9.8 * (fdk - rollingCoeffience) / d[3, i];
      if ak < 0.01 or ah <= ak then
        dt := (vk - vh) / ah / 3.6;
        ds := (vk - dv / 2) * dt / 3.6;    
      else         
        dt := (vk - vh) * log(ak / ah) / (ak - ah);
        ds := ((vk - vh) ^ 2 - (vk * ah - ak * vh) * dt) / (ak - ah); 
      end if;
      t[i, j] := t0;
      s[i, j] := s0;
      v[i, j] := v0;
      t0 := t0 + dt;
      s0 := s0 + ds;
      v0 := velocity[i, j + 1];
    end for;
    t[i, columns] := t0;
    s[i, columns] := s0;
    v[i, columns] := v0;
    as := 9.8 * (d[1, i] + rollingCoeffience) / d[3, i];
    dv := as * d[2, i] * 3.6;
    ds := (v0 - dv / 2) * d[2, i] / 3.6;
    t0 := t0 + d[2, i];
    v0 := v0 - dv;
    s0 := s0 + ds;
    t[i, end] := t0;
    v[i, end] := v0;
    s[i, end] := s0;
    if i < rows then
      ak := 9.8 * (dynamicFactor[i + 1, 1] - rollingCoeffience) / d[3, i + 1];
      dt := dv / ak / 3.6;
      ds := (velocity[i + 1, 1] - dv / 2) * dt / 3.6;
      t0 := t0 + dt;
      s0 := s0 + ds;
    end if;
  end for;

end accelerationCharacteristics;
