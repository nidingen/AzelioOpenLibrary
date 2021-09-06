within AzelioOpenLibrary.Gensets;

model Fuel_Power_Table
  Modelica.Blocks.Interfaces.RealInput P_dem(unit = "W") "Power demand" annotation(Placement(visible = true, transformation(origin = {-155, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-95, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  parameter Real P_Nom(unit = "W") "Nominal genset power" annotation(Placement(visible = true, transformation(origin = {-155, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98.908, -15.426}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput pnom(unit = "W") "Nominal genset power to be input in nec´xt block" annotation(Placement(visible = true, transformation(origin = {-18.742, 42.241}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 105}, extent = {{-25, -25}, {25, 25}}, rotation = -270)));
  Modelica.Blocks.Interfaces.RealOutput k "Power coefficient to determine fuel consumption" annotation(Placement(visible = true, transformation(origin = {160, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {105, 0}, extent = {{-25, -25}, {25, 25}}, rotation = -720)));
equation
  pnom = P_Nom;
  P_dem / P_Nom = k;
  annotation(Documentation(info = "<p>This block take the hourly demand and for each time step it determines the power ratio:</p>
<p><em>k&nbsp;= P<sub>dem</sub>/P<sub>Nom</sub></em></p>
<p>This is subsequently the input to calculate the actual fuel consumption from the manufaturer table.&nbsp;</p>
<p>Two inputs required:</p>
<ul>
<li><em>P<sub>Nom</sub></em>, as parameter [kW];</li>
<li><em>P<sub>dem</sub></em>, as hourly data [kW].</li>
</ul>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Text(visible = true, origin = {-2.391, 40}, textColor = {149, 23, 41}, extent = {{-67.609, -23.727}, {67.609, 23.727}}, textString = "POWER", textStyle = {TextStyle.Italic, TextStyle.Bold}), Text(visible = true, origin = {-2.391, -36.273}, textColor = {149, 23, 41}, extent = {{-67.609, -23.727}, {67.609, 23.727}}, textString = "TABLE", textStyle = {TextStyle.Italic, TextStyle.Bold})}), Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Fuel_Power_Table;
