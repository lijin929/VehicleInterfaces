within VehicleInterfaces.Controllers;

model shiftState
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(origin = {66, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.InitialStep initialStep(nOut = 1, nIn = 1)  annotation(
    Placement(visible = true, transformation(origin = {-60, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Alternative alternative annotation(
    Placement(visible = true, transformation(origin = {38, 8}, extent = {{-58, -78}, {58, 78}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal T0 annotation(
    Placement(visible = true, transformation(origin = {14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step Neural(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {46, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal T1 annotation(
    Placement(visible = true, transformation(origin = {14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step Hold(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {46, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal T2 annotation(
    Placement(visible = true, transformation(origin = {14, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal T3 annotation(
    Placement(visible = true, transformation(origin = {14, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step UpShift(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {46, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step DownShift(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {46, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression neutralAct(y = neutral.active) annotation(
    Placement(visible = true, transformation(origin = {-65, 40}, extent = {{-25, -10}, {25, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression holdAct(y = neutral.active) annotation(
    Placement(visible = true, transformation(origin = {-65, 2}, extent = {{-25, -10}, {25, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression upshiftAct(y = neutral.active) annotation(
    Placement(visible = true, transformation(origin = {-65, -32}, extent = {{-25, -10}, {25, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression downshiftAct(y = neutral.active) annotation(
    Placement(visible = true, transformation(origin = {-63, -66}, extent = {{-25, -10}, {25, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput pedal annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-106, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput speed annotation(
    Placement(visible = true, transformation(origin = {-120, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput currentGear annotation(
    Placement(visible = true, transformation(origin = {-120, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(initialStep.outPort[1], alternative.inPort) annotation(
    Line(points = {{-49.5, 78}, {-26.75, 78}, {-26.75, 8}, {-22, 8}}));
  connect(alternative.outPort, initialStep.inPort[1]) annotation(
    Line(points = {{97, 8}, {98, 8}, {98, 96}, {-90, 96}, {-90, 78}, {-71, 78}}));
  connect(T0.inPort, alternative.split[1]) annotation(
    Line(points = {{10, 58}, {0, 58}, {0, 8}, {-8, 8}}));
  connect(T0.outPort, Neural.inPort[1]) annotation(
    Line(points = {{15.5, 58}, {35, 58}}));
  connect(Neural.outPort[1], alternative.join[1]) annotation(
    Line(points = {{56.5, 58}, {68, 58}, {68, 8}, {84, 8}}));
  connect(Hold.inPort[1], T1.outPort) annotation(
    Line(points = {{35, 22}, {15, 22}}));
  connect(T2.outPort, UpShift.inPort[1]) annotation(
    Line(points = {{15.5, -14}, {35.5, -14}}));
  connect(T3.outPort, DownShift.inPort[1]) annotation(
    Line(points = {{15.5, -48}, {35.5, -48}}));
  connect(T1.inPort, alternative.split[2]) annotation(
    Line(points = {{10, 22}, {0, 22}, {0, 8}, {-8, 8}}));
  connect(T2.inPort, alternative.split[3]) annotation(
    Line(points = {{10, -14}, {0, -14}, {0, 8}, {-8, 8}}));
  connect(T3.inPort, alternative.split[4]) annotation(
    Line(points = {{10, -48}, {0, -48}, {0, 8}, {-8, 8}}));
  connect(Hold.outPort[1], alternative.join[2]) annotation(
    Line(points = {{56.5, 22}, {68.5, 22}, {68.5, 8}, {84.5, 8}}));
  connect(UpShift.outPort[1], alternative.join[3]) annotation(
    Line(points = {{56.5, -14}, {68.5, -14}, {68.5, 8}, {84.5, 8}}));
  connect(DownShift.outPort[1], alternative.join[4]) annotation(
    Line(points = {{56.5, -48}, {68.5, -48}, {68.5, 8}, {84.5, 8}}));
  connect(neutralAct.y, T0.condition) annotation(
    Line(points = {{-37.5, 40}, {14, 40}, {14, 46}}, color = {255, 0, 255}));
  connect(booleanExpression.y, T1.condition) annotation(
    Line(points = {{-38, 2}, {14, 2}, {14, 10}}, color = {255, 0, 255}));
  connect(holdAct.y, T1.condition) annotation(
    Line(points = {{-38, 2}, {14, 2}, {14, 10}}, color = {255, 0, 255}));
  connect(upshiftAct.y, T2.condition) annotation(
    Line(points = {{-38, -32}, {14, -32}, {14, -26}}, color = {255, 0, 255}));
  connect(downshiftAct.y, T3.condition) annotation(
    Line(points = {{-36, -66}, {14, -66}, {14, -60}}, color = {255, 0, 255}));
end shiftState;
