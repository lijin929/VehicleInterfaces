within VehicleInterfaces.Blocks;

function intersectionWithTwoCurves
  input Real x1[:] "x array in curve1";
  input Real y1[size(x1,1)] "y array in curve1";
  input Real x2[:] "x array in curve2";
  input Real y2[size(x2,1)] "y array in curve2";
  output Real x;
  output Real y;

protected  
  Integer num = 10;
  Real xNew[num];
  Real y1New[num];
  Real y2New[num];
  Real xMin;
  Real xMax;

algorithm
  if x1[end] > x2[1] then
    xMin := x2[1];
    xMax := x1[end];
    xNew := linspace(xMin, xMax, num);
    for i in 1:num loop
      y1New[i] := Modelica.Math.Vectors.interpolate(x1,y1,xNew[i]);
      y2New[i] := Modelica.Math.Vectors.interpolate(x2,y2,xNew[i]);
    end for;
    if (y1New[1]-y2New[1])*(y1New[end]-y2New[end])<0 then
      x := Modelica.Math.Vectors.interpolate(y2New-y1New,xNew,0);
      y := Modelica.Math.Vectors.interpolate(x1,y1,x);
    else
      x := x1[end];
      y := y1[end];
    end if;
  else
    x := x1[end];
    y := y1[end];
  end if;


end intersectionWithTwoCurves;
