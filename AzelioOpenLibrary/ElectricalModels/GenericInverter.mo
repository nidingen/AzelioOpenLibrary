within AzelioOpenLibrary.ElectricalModels;

model GenericInverter "Inverter"
  Modelica.Blocks.Interfaces.RealInput Pin(unit = "W") "Gross Power Output" annotation(Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-20, -20}, {20, 20}}, rotation = -360), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealInput Pnom1(unit = "W") if usePnomInput "Nominal power" annotation(Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 52.066}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  parameter Boolean usePnomInput = true "If true give Pnom as input, if false as parameter";
  parameter Real eta_inv = 0.98 "Inverter efficiency" annotation(Placement(visible = true, transformation(origin = {-104.321, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real Pnominal(unit = "W") = 11000 "Nominal input, if not input via interface";
  parameter Real Pmax(unit = "W") = 100e6 "Max power inverter can handle";
  Modelica.Blocks.Interfaces.RealOutput Pout(unit = "W", start = 0) "Net power output to grid" annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-20, -20}, {20, 20}}, rotation = -360), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealOutput Eout(unit = "J", start = 0) "Net energy output to grid" annotation(Placement(visible = true, transformation(origin = {110, -20}, extent = {{-20, -20}, {20, 20}}, rotation = -360), iconTransformation(origin = {100, 8.236}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Sources.Constant Pnom2(k = Pnominal) if not usePnomInput annotation(Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = eta_inv) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division1 annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput CF(unit = "J") "Net energy output to grid" annotation(Placement(visible = true, transformation(origin = {110, -60}, extent = {{-20, -20}, {20, 20}}, rotation = -360), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Math.Gain gain2(k = 1 / (8760 * 3600)) annotation(Placement(visible = true, transformation(origin = {36.209, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = Pmax, uMin = 0) annotation(Placement(visible = true, transformation(origin = {-60, -0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Pout = der(Eout);
  //Eout = division1.u1;
  connect(gain1.y, Pout) annotation(Line(visible = true, origin = {60.5, 0}, points = {{-49.5, 0}, {49.5, 0}}, color = {1, 37, 163}));
  connect(Pnom2.y, division1.u2) annotation(Line(visible = true, origin = {-50.714, 3.507}, points = {{-8.286, 56.493}, {10.714, 56.493}, {10.714, -39.507}, {38.714, -39.507}}, color = {1, 37, 163}));
  connect(Pnom1, division1.u2) annotation(Line(visible = true, origin = {-63, 12}, points = {{-47, 18}, {23, 18}, {23, -48}, {51, -48}}, color = {1, 37, 163}));
  connect(division1.y, gain2.u) annotation(Line(visible = true, origin = {17.604, -30}, points = {{-6.604, 0}, {6.605, 0}}, color = {1, 37, 163}));
  connect(gain2.y, CF) annotation(Line(visible = true, origin = {82.577, -45}, points = {{-35.368, 15}, {3.973, 15}, {3.973, -15}, {27.423, -15}}, color = {1, 37, 163}));
  connect(Eout, division1.u1) annotation(Line(visible = true, origin = {40.183, -23.662}, points = {{69.817, 3.662}, {46.367, 3.662}, {46.367, 9.431}, {-55.183, 9.431}, {-55.183, -0.338}, {-52.183, -0.338}}, color = {1, 37, 163}));
  connect(Pin, limiter1.u) annotation(Line(visible = true, origin = {-91, -0}, points = {{-19, 0}, {19, -0}}, color = {1, 37, 163}));
  connect(limiter1.y, gain1.u) annotation(Line(visible = true, origin = {-30.5, -0}, points = {{-18.5, -0}, {18.5, 0}}, color = {1, 37, 163}));
  annotation(Documentation(info = "<p>This model represents an inverter: it converts DC power input into AC power output by means of a constant inverter efficiency. Then, it determines the energy yield <em>E<sub>AC</sub></em></p>
<p>It calculates the capacity factor <em>CF</em> as wel:</p>
<p><em>CF = E<sub>AC</sub>/(8760&nbsp;&middot; P<sub>Nom</sub>)</em></p>
<p>where <em>P<sub>Nom</sub></em> is the nominal power of the PV array (or other facility).</p>
<p>Inputs:</p>
<ul>
<li>Inverter efficiency <span style=\"font-family: symbol;\">h</span><sub>inv</sub>;</li>
<li>Nominal power of PV array, or other facility [W];</li>
<li>DC power [W]</li>
</ul>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Rectangle(visible = true, origin = {0, -2.366}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, lineThickness = 10, extent = {{-81.162, -82.634}, {81.162, 82.634}}, radius = 5), Line(visible = true, origin = {0.376, -1.473}, points = {{-76.928, -78.527}, {76.928, 78.527}}, color = {149, 23, 41}, thickness = 10), Line(visible = true, origin = {30.618, -35}, points = {{-31.385, 0}, {31.385, 0}}, color = {149, 23, 41}, thickness = 10), Line(visible = true, origin = {13.57, -50}, points = {{-13.57, 0}, {13.57, 0}}, color = {149, 23, 41}, thickness = 10), Line(visible = true, origin = {48.57, -50}, points = {{-13.57, 0}, {13.57, 0}}, color = {149, 23, 41}, thickness = 10), Line(visible = true, origin = {-31.361, 41.452}, points = {{-28.639, -6.452}, {-6.543, 23.548}, {16.361, -13.843}, {36.361, 13.548}}, color = {149, 23, 41}, thickness = 10, smooth = Smooth.Bezier)}));
end GenericInverter;
