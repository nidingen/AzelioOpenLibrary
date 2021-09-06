within AzelioOpenLibrary.WindTurbines;

model LogWindProfile
  Modelica.Blocks.Interfaces.RealInput v(unit = "m/s") "Wind speed at location" annotation(Placement(visible = true, transformation(origin = {-155, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-20, -20}, {20, 20}}, rotation = -270)));
  parameter Real z_0(unit = "m") = 0.05 "Surface roughness length class II by ISO standard" annotation(Placement(visible = true, transformation(origin = {-143.171, 17.354}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  constant Real c_o = 1 "Orography coefficient";
  parameter Real h(unit = "m") "Wind turbine hub height" annotation(Placement(visible = true, transformation(origin = {-142.382, -58.373}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput v_h(unit = "m/s") "Wind speed at hub height" annotation(Placement(visible = true, transformation(origin = {148.5, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput hh(unit = "m") "Hub height for next block" annotation(Placement(visible = true, transformation(origin = {72.041, 80.755}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -270)));
  Real c_r "Roughness coefficient", k_r "Terrain factor";
equation
  k_r = 0.19 * (z_0 / 0.05) ^ 0.07;
  c_r = k_r * log(h / z_0);
  v_h = c_r * c_o * v;
  hh = h;
  annotation(Documentation(info = "<p>This block calculates the wind speed at hub height as described in [1]:</p>
<p style=\"text-align: left;\"><em>v<sub>h</sub> = c<sub>r</sub>&nbsp;&middot; c<sub>o</sub>&nbsp;&middot; v</em></p>
<p>where</p>
<ul>
<li><em>v<sub>h</sub></em> is the wind speed at hub height [m/s];</li>
<li>c<sub>r</sub>&nbsp;is the roughness coefficient [-];</li>
<li><em>c<sub>o</sub></em> is the orography coefficient [-], generically set to 1.00, according to [1]; and</li>
<li><em>v</em> is TMY wind speed at location [m/s].</li>
</ul>
<p><em>c</em><sub><em>r</em>&nbsp;</sub>is&nbsp;defined as:</p>
<p style=\"text-align: left; padding-left: 60px;\">&nbsp;<em>c<sub>r</sub> = k<sub>r</sub>&nbsp;&middot; ln(h/z<sub>0</sub>)</em></p>
<p style=\"text-align: left;\">where</p>
<ul>
<li><em>k<sub>r</sub></em> is the terrain coefficient [-] <em>k<sub>r</sub> = 0.19&nbsp;&middot; (z<sub>0</sub>/0.05)<sup>0.07</sup></em>;</li>
<li><em>z<sub>0</sub></em> is the roughness length, defined by Table 1 [m]; and</li>
<li><em>h</em> is the wind turbine hub height [m].</li>
</ul>
<p style=\"text-align: center;\">Table 1</p>
<table style=\"height: 155px; margin-left: auto; margin-right: auto;\" width=\"695\">
<tbody>
<tr>
<td style=\"text-align: center;\"><strong>Terrain category</strong></td>
<td style=\"text-align: center;\"><strong>Description</strong></td>
<td style=\"text-align: center;\"><strong>z<sub>0</sub></strong></td>
</tr>
<tr>
<td style=\"text-align: center;\">0</td>
<td>Sea or costal area exposed to the open sea</td>
<td style=\"text-align: center;\">0.003</td>
</tr>
<tr>
<td style=\"text-align: center;\">I</td>
<td>Lakes or flat and horizontal area with negligible vegetation and without obstacles</td>
<td style=\"text-align: center;\">&nbsp;0.01</td>
</tr>
<tr>
<td style=\"text-align: center;\">II</td>
<td>Area with low vegetation&nbsp;such as grass and isolated obstacles&nbsp;(trees, buildings) with separations of at least 20 obstacle heights</td>
<td style=\"text-align: center;\">0.05&nbsp;</td>
</tr>
<tr>
<td style=\"text-align: center;\">III</td>
<td>Area with regular cover of vegetation or buildings or with isolated&nbsp;obstacles with separations of maximum 20 obstacle heights (such&nbsp;as villages, suburban terrain, permanent forest)</td>
<td style=\"text-align: center;\">0.3&nbsp;</td>
</tr>
<tr>
<td style=\"text-align: center;\">IV</td>
<td>Area in which at least 15 % of the surface is covered with buildings&nbsp;and their average height exceeds 15 m</td>
<td style=\"text-align: center;\">1&nbsp;</td>
</tr>
</tbody>
</table>
<p>&nbsp;Inputs required:</p>
<ul>
<li><em>z<sub>0</sub></em>;</li>
<li><em>c<sub>o</sub></em>;</li>
<li><em>h</em>.</li>
</ul>
<h2>Reference</h2>
<p>[1] <em>Eurocode 1: Actions on structures - General Actions . Part 1-4: Wind actions</em>, January 2004</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Line(visible = true, origin = {1.37, -57.444}, points = {{-78.63, 0}, {78.63, 0}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {-27.831, 4.564}, points = {{0, 61.118}, {0, -61.118}}, color = {149, 23, 41}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {8.23, 56.123}, points = {{35.409, 0}, {-35.409, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {7.777, 40}, points = {{35.194, 0}, {-35.194, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {7.125, 22.871}, points = {{34.511, 0}, {-34.511, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {-23.609, 1.01}, points = {{67.916, 63.336}, {66.135, 18.99}, {52.108, -41.01}, {-3.777, -56.673}}, color = {149, 23, 41}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {5.347, 4.629}, points = {{32.949, 0}, {-32.949, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {3.001, -13.835}, points = {{30.619, 0}, {-30.619, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {-0.458, -30}, points = {{27.176, 0}, {-27.176, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier), Line(visible = true, origin = {-10.248, -45.57}, points = {{16.928, 0}, {-16.928, 0}}, color = {149, 23, 41}, thickness = 1, arrow = {Arrow.Open, Arrow.None}, arrowSize = 5, smooth = Smooth.Bezier)}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end LogWindProfile;
