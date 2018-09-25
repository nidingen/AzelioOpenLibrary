within AzelioOpenLibrary.LossModels;

model GenericLoss "Generic loss model for e.g. friction in a Stirling engine. Dependend on shaft speed and working pressure."
  Modelica.Blocks.Interfaces.RealInput pme "Mean working gas pressure in the engine [bar]" annotation(Placement(visible = true, transformation(origin = {-105, 51.726}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-97.281, 42.719}, extent = {{-17.281, -17.281}, {17.281, 17.281}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nshaft "Engine shaft speed [rpm]" annotation(Placement(visible = true, transformation(origin = {-105, 85}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-97.453, 80}, extent = {{-17.453, -17.453}, {17.453, 17.453}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Wt "Thermodynamic work [W]" annotation(Placement(visible = true, transformation(origin = {-105, -0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-97.428, -0}, extent = {{-17.428, -17.428}, {17.428, 17.428}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Wshaft "Shaft work [W]" annotation(Placement(visible = true, transformation(origin = {105.77, 0}, extent = {{-14.23, -14.23}, {14.23, 14.23}}, rotation = 0), iconTransformation(origin = {102.737, 0}, extent = {{-17.263, -17.263}, {17.263, 17.263}}, rotation = 0)));
  parameter Real C0 = 2300.0;
  parameter Real C1 = -1.4;
  parameter Real C2 = -17.0;
  parameter Real C3 = 0.0005;
  parameter Real C4 = 0.05;
  parameter Real C5 = 0.01;
  Real Wloss;
  Boolean engineOn "Determines if the engine is on or not, i.e. output is Wt + Wloss or 0";
equation
  //Friction and auxiliary (oil pump) losses
  Wloss = -(C0 + C1 * nshaft + C2 * pme + C3 * nshaft ^ 2 + C4 * pme ^ 2 + C5 * nshaft * pme);
  if Wt + Wloss > 0 then
    engineOn = true;
  else
    engineOn = false;
  end if;
  if engineOn then
    Wshaft = Wt + Wloss;
  else
    Wshaft = 0;
  end if;
  annotation(Documentation(info = "<p>Loss is dependent on shaft speed, nshaft [rpm], and mean working gas pressure, pme [bar]:</p>
<p>Wloss = -(C0 + C1 * nshaft + C2 * pme + C3 * nshaft ^ 2 + C4 * pme ^ 2 + C5 * nshaft * pme)</p>
<p>Constants C0...C5 are changeable by the user.</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Ellipse(visible = true, origin = {0.141, -0.141}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, extent = {{-70.141, -70.141}, {70.141, 70.141}}), Line(visible = true, origin = {-26.782, -0.521}, points = {{0.14, -56.992}, {7.5, -41.017}, {-15.778, -26.992}, {9.343, -9.18}, {-12.5, 9.475}, {7.5, 23.008}, {-5.083, 35.342}, {-2.5, 44.545}}, color = {255, 255, 255}, thickness = 2, smooth = Smooth.Bezier), Polygon(visible = true, origin = {-29.655, 50.201}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0, 7.93}, {-5.319, -8.333}, {4.63, -8.333}}), Polygon(visible = true, origin = {0.345, 50.201}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0, 7.93}, {-5.319, -8.333}, {4.63, -8.333}}), Polygon(visible = true, origin = {30.345, 50.201}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0, 7.93}, {-5.319, -8.333}, {4.63, -8.333}}), Line(visible = true, origin = {3.218, -0.561}, points = {{0.14, -56.992}, {7.5, -41.017}, {-15.778, -26.992}, {9.343, -9.18}, {-12.5, 9.475}, {7.5, 23.008}, {-5.083, 35.342}, {-2.5, 44.545}}, color = {255, 255, 255}, thickness = 2, smooth = Smooth.Bezier), Line(visible = true, origin = {33.218, -0.602}, points = {{0.14, -56.992}, {7.5, -41.017}, {-15.778, -26.992}, {9.343, -9.18}, {-12.5, 9.475}, {7.5, 23.008}, {-5.083, 35.342}, {-2.5, 44.545}}, color = {255, 255, 255}, thickness = 2, smooth = Smooth.Bezier)}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end GenericLoss;
