within AzelioOpenLibrary.ThermalModels;

model GenericHEX "Generic heat exchanger"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation(choicesAllMatching = true);
  Modelica.Fluid.Interfaces.FluidPort_a inlet(redeclare package Medium = Medium) annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Fluid.Interfaces.FluidPort_b outlet(redeclare package Medium = Medium) annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HEX_port(T(displayUnit = "K")) "Heat to/from engine [W]" annotation(Placement(visible = true, transformation(origin = {-20, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //parameter
  parameter Modelica.SIunits.Volume V = 1e-3 "Volume";
  parameter Modelica.SIunits.Temperature T_nom = 283.15 "Nominal liquid temperature, used for fixed density calculation";
  // Constants for heat transfer coefficient
  parameter Real c0(unit = "W/m2.K") = 1864.7 "W/m2.K";
  parameter Real cx1(unit = "W.h/m5.K") = 3401.8 "W.h/m5.K";
  parameter Real cx2(unit = "W.h2/m8.K") = -588.17 "W.h2/m8.K";
  //Variable
  Modelica.SIunits.Density d = Medium.density(Medium.setState_pTX(p, T_nom, cat(1, inStream(inlet.Xi_outflow), {1 - sum(inStream(inlet.Xi_outflow))}))) "Fixed liquid density, used in energy balance";
  Modelica.Blocks.Interfaces.RealOutput HTC "Heat transfer coefficient [W/(m2K]" annotation(Placement(visible = true, transformation(origin = {11.784, 106.058}, extent = {{-10, -10}, {10, 10}}, rotation = -270), iconTransformation(origin = {30, 100}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  Modelica.SIunits.Temperature T(start = 298.15) "Temperature";
  Modelica.SIunits.MassFlowRate m_flow "Mass flow rate";
  Modelica.SIunits.HeatFlowRate Q "Heat flow rate over thermal connector";
  Modelica.SIunits.VolumeFlowRate V_flow "Volume flow rate";
  Modelica.SIunits.Mass m = V * d "Fixed liquid mass, used in energy balance";
  Modelica.SIunits.HeatFlowRate dE "Internal energy derivative";
  Medium.ThermodynamicState state = Medium.setState_pTX(p, T, cat(1, actualStream(inlet.Xi_outflow), {1 - sum(actualStream(inlet.Xi_outflow))})) "Liquid state";
protected
  Modelica.SIunits.AbsolutePressure p "Fluid pressure, assumed constant";
equation
  /* Port connections */
  m_flow = inlet.m_flow;
  inlet.p = p;
  outlet.p = inlet.p;
  outlet.h_outflow = Medium.specificEnthalpy(state);
  inlet.h_outflow = outlet.h_outflow "This is the outlet enthalpy for the reversed flow case";
  /* Mass balance */
  0 = inlet.m_flow + outlet.m_flow;
  /* Energy balance */
  dE = inlet.m_flow * actualStream(inlet.h_outflow) + outlet.m_flow * actualStream(outlet.h_outflow) + Q;
  dE = m * Medium.specificHeatCapacityCp(state) * der(T);
  V_flow = m_flow / d;
  HEX_port.T = T;
  HTC = 1.3 * (c0 + cx1 * (V_flow * 3600) + cx2 * (V_flow * 3600) ^ 2);
  Q = HEX_port.Q_flow;
  /* Propagation of species and trace components */
  /* Quasi-static mass balance gives direct propagation
     of substances from inlet to outlet and vice versa */
  outlet.Xi_outflow = inStream(inlet.Xi_outflow);
  inlet.Xi_outflow = inStream(outlet.Xi_outflow);
  outlet.C_outflow = inStream(inlet.C_outflow);
  inlet.C_outflow = inStream(outlet.C_outflow);
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Line(visible = true, origin = {-57.193, 47.301}, points = {{-28.492, -28.467}, {14.246, 0.078}, {14.246, 28.389}}, color = {149, 23, 41}, thickness = 5), Line(visible = true, origin = {-57.193, -47.648}, points = {{-28.492, 28.467}, {14.246, -0.078}, {14.246, -28.389}}, color = {149, 23, 41}, thickness = 5), Line(visible = true, origin = {55.824, 46.977}, points = {{28.492, -28.467}, {-14.246, 0.078}, {-14.246, 28.389}}, color = {149, 23, 41}, thickness = 5), Line(visible = true, origin = {57.193, -47.648}, points = {{28.492, 28.467}, {-14.246, -0.078}, {-14.246, -28.389}}, color = {146, 23, 41}, thickness = 5), Rectangle(visible = true, origin = {0.46, 0}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-36.144, -76.158}, {36.144, 76.158}}, radius = 2), Line(visible = true, origin = {-29.017, 0.819}, points = {{113.333, 0}, {-56.667, 0}, {-56.667, 0}}, color = {85, 170, 0}, thickness = 5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 15), Text(visible = true, origin = {0, -137.317}, textColor = {149, 23, 41}, extent = {{-160, -37.317}, {160, 37.317}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end GenericHEX;
