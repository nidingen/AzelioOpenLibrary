within AzelioOpenLibrary.ElectricalModels;

model GenericGenerator "Efficiency model of a generic 15 kW permanent magnet generator."
  Modelica.Blocks.Interfaces.RealInput Wshaft "Shaft work from Stirling engine" annotation(Placement(visible = true, transformation(origin = {-156.526, 0}, extent = {{-16.526, -16.526}, {16.526, 16.526}}, rotation = 0), iconTransformation(origin = {-100, -0}, extent = {{-16.752, -16.752}, {16.752, 16.752}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pgenerator "Generator power output" annotation(Placement(visible = true, transformation(origin = {153.651, 0}, extent = {{-13.651, -13.651}, {13.651, 13.651}}, rotation = 0), iconTransformation(origin = {104.793, 0}, extent = {{-15.207, -15.207}, {15.207, 15.207}}, rotation = 0)));
  Modelica.SIunits.Energy Egenerator;
  Real eta_generator;
  parameter Real C0 = 8.00E-01 "Constant coefficient";
  parameter Real C1 = 2.1E-05 "Linear coefficient";
  parameter Real C2 = -7.75E-10 "Quadratic coefficient";
equation
  //Losses in generator
  eta_generator = C0 + C1 * Wshaft + C2 * Wshaft ^ 2 "Generator efficiency";
  Pgenerator = Wshaft * eta_generator;
  der(Egenerator) = Pgenerator;
  annotation(__Wolfram(itemFlippingEnabled = true), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Rectangle(visible = true, origin = {6.786, -3.109}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-76.786, -49.87}, {76.786, 49.87}}, radius = 2), Rectangle(visible = true, origin = {-41.469, -62.188}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{11.469, -12.188}, {-11.469, 12.188}}, radius = 3), Rectangle(visible = true, origin = {56.321, -62.188}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{11.469, -12.188}, {-11.469, 12.188}}, radius = 3), Rectangle(visible = true, origin = {25.121, 43.233}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-46.761, -36.767}, {46.761, 36.767}}, radius = 5), Rectangle(visible = true, origin = {25.129, 45}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-41.529, -35}, {41.529, 35}}, radius = 3), Rectangle(visible = true, origin = {-44.273, 31.416}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-75.24, -5.794}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8.084, -25.794}, {8.084, 25.794}}, radius = 3), Rectangle(visible = true, origin = {-72.433, -5.867}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-2.433, -28.644}, {2.433, 28.644}}), Polygon(visible = true, origin = {24.68, 39.107}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-5.845, 6.964}, {-20.769, -20.893}, {13.307, 6.964}, {13.307, 6.964}}), Polygon(visible = true, origin = {31.718, 63.036}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-8.835, 6.964}, {-21.718, -20.893}, {-11.718, -20.893}, {13.307, 6.964}, {13.307, 6.964}}), Rectangle(visible = true, origin = {-44.004, 23.692}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-44.01, 16.244}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-44.373, -18.584}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-44.241, -26.86}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-44.248, -34.17}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Rectangle(visible = true, origin = {-44.53, -41.416}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-11.441, -1.416}, {11.441, 1.416}}), Text(visible = true, origin = {0.729, 123.514}, textColor = {149, 23, 41}, extent = {{-90.729, -23.514}, {90.729, 23.514}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end GenericGenerator;
