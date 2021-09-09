within AzelioOpenLibrary.WindTurbines;

model Wind_farm
  Modelica.Blocks.Interfaces.RealInput P_WT(unit = "W") "Power output of one turbine" annotation(Placement(visible = true, transformation(origin = {337.526, -24.944}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealInput E_WT(unit = "J") "Energy yield of one turbine" annotation(Placement(visible = true, transformation(origin = {221.203, 11.461}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -720)));
  parameter Real turb "Turbulence intensity";
  parameter Real CWS "Crosswind spacing/Turbine diameter";
  parameter Real N_WT "Number of wind turbines";
  Real AL "Array losses", a1, a2, a3, a4;
  Modelica.Blocks.Interfaces.RealOutput E_WF(unit = "J") annotation(Placement(visible = true, transformation(origin = {219.297, 41.798}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealOutput P_WF(unit = "W") annotation(Placement(visible = true, transformation(origin = {193.553, 56.63}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
equation
  a1 = (-0.026 * turb) - 0.0212;
  a2 = 0.565 * turb + 0.6829;
  a3 = (-3.818 * turb) - 7.2651;
  a4 = (-22.06 * turb) - 33.893;
  AL = (a1 * CWS ^ 3 + a2 * CWS ^ 2 + a3 * CWS + a4) / 100;
  if noEvent(N_WT > 0) then
    E_WF = (1 - AL) * N_WT * E_WT;
  else
    E_WF = 0;
  end if;
  P_WF = der(E_WF);
  annotation(Documentation(info = "<html><p>This block simulates the power and energy output (<em>P<sub>WF</sub>, E<sub>WF</sub></em>) of a windfarm, by accounting for array losses [1, 2].&nbsp;</p>
<p><em>E<sub>WF</sub> = (1-AL)&nbsp;&middot; N<sub>WT</sub>&nbsp;&middot; E<sub>WT</sub></em></p>
<p><em>P<sub>WF</sub> = der(E<sub>WF</sub>)</em></p>
<p>where:</p>
<ul>
<li><em>AL</em> are the array losses;</li>
<li><em>N<sub>WT</sub></em> is the number of wind turbines; and</li>
<li><em>E<sub>WT</sub></em> is the energy yield of a single wind turbine.</li>
</ul>
<p>The array losses are determined according to [1, 2] as function of the turbulence inensity and the ratio between the crosswind spacing and the turbine diameter, when considering a dowind spacing between 8 and 10 rotor diameters. Third grade polynomial where obtained from Figure 1 when considering all wind directions.</p>
<p><em>AL = a<sub>1</sub>&nbsp;&middot; CWS<sub>D</sub><sup>3</sup> + a<sub>2</sub> &middot; CWS<sub>D</sub><sup>2</sup> + a<sub>3</sub>&nbsp;&middot; CWS<sub>D</sub> + a<sub>4</sub>;</em></p>
<p>where <em>a<sub>1</sub>, ..., a<sub>4</sub></em> are the polynomial coefficients and <em>CWS<sub>D</sub></em> is the crosswind spacing-rotor diameter ratio. The dependence of the coefficients <em>a<sub>1</sub>, ..., a<sub>4</sub></em>&nbsp; on the turbulence intensity are linearized in the model. The linear equations for <em>a<sub>1</sub>, ..., a<sub>4</sub></em> are known to work in the turbulence intensity range 0.05 to 0.15.</p>
<p>The turbulence intensity can be chosen among the following values: 0.05, 0.10, 0.15.</p>
<p>This model requires three inputs:</p>
<ul>
<li>Turbulence intensity;</li>
<li>CWSD, as a rule-of-thumb, the crosswind spacing is usually 4 times the rotor diameter; and&nbsp;</li>
<li>NWT.</li>
</ul>
<p>As usually the downwind spacing, referring to the main wind direction is 7 rotor diameters, this windfarm model can be used as a reference and preliminary calculation.</p>
<h2>Reference</h2>
<p>[1]&nbsp;<em>Wind Energy Explained</em>, Manwell et al, 2nd Edition</p>
<p>[2]&nbsp;Lissaman, P. B. S., Zaday, A. and Gyatt, G. W. (1982) Critical issues in the design and assessment of wind turbine<br />arrays. Proc. 4th International Symposium on Wind Energy Systems, Stockholm</p></html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Line(visible = true, origin = {-50, 8.925}, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Rectangle(visible = true, origin = {-50, -38.225}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 1, extent = {{-1.25, -27.5}, {1.25, 27.5}}), Ellipse(visible = true, origin = {-50, -8.225}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-2.5, -2.5}, {2.5, 2.5}}), Line(visible = true, origin = {-64.852, -16.975}, rotation = 120, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {-35.148, -16.898}, rotation = 240, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {0, 57.5}, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {-14.852, 31.6}, rotation = 120, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {14.852, 31.677}, rotation = 240, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Rectangle(visible = true, origin = {0, 10.35}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 1, extent = {{-1.25, -27.5}, {1.25, 27.5}}), Ellipse(visible = true, origin = {0, 40.35}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-2.5, -2.5}, {2.5, 2.5}}), Line(visible = true, origin = {50, 7.5}, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {35.148, -18.4}, rotation = 120, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {64.852, -18.323}, rotation = 240, points = {{0, 22.5}, {-3, -2.15}, {-3, -12.15}, {0, -17.15}, {3, -12.15}, {3, -2.15}, {0, 22.5}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Rectangle(visible = true, origin = {50, -39.65}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 1, extent = {{-1.25, -27.5}, {1.25, 27.5}}), Ellipse(visible = true, origin = {50, -9.65}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-2.5, -2.5}, {2.5, 2.5}})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Wind_farm;
