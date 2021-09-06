within AzelioOpenLibrary.Utilities;

model Radians_Conv
  Modelica.Blocks.Interfaces.RealInput Sun_Azim_deg annotation(Placement(visible = true, transformation(origin = {-149.939, 53.837}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Elev_deg annotation(Placement(visible = true, transformation(origin = {-147.596, -50.11}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Sun_Azim_rad annotation(Placement(visible = true, transformation(origin = {147.01, 44.312}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Sun_Elev_rad annotation(Placement(visible = true, transformation(origin = {79.069, -18.636}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  Sun_Azim_rad = Modelica.SIunits.Conversions.from_deg(Sun_Azim_deg + 180);
  Sun_Elev_rad = Modelica.SIunits.Conversions.from_deg(Sun_Elev_deg);
  annotation(Documentation(info = "<p>This blocks converts angles in degrees to angles in radians.</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Text(visible = true, origin = {-2.416, -53.8}, textColor = {150, 25, 43}, extent = {{-90, -42.067}, {90, 42.067}}, textString = "rad", textStyle = {TextStyle.Italic, TextStyle.Bold}), Text(visible = true, origin = {0, 52.067}, textColor = {150, 25, 43}, extent = {{-90, -42.067}, {90, 42.067}}, textString = "deg", textStyle = {TextStyle.Italic, TextStyle.Bold}), Text(visible = true, origin = {-5.804, -8.279}, textColor = {150, 25, 43}, extent = {{-90, -28.279}, {90, 28.279}}, textString = "2", textStyle = {TextStyle.Italic, TextStyle.Bold})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Radians_Conv;
