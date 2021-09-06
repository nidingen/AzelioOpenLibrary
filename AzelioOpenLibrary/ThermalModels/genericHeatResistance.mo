within AzelioOpenLibrary.ThermalModels;

model genericHeatResistance "Cavity wall with insulationg properties"
  //HTF circuit parameters
  parameter Modelica.SIunits.ThermalConductance Ghtf = 1550 "Thermal conductance in HTF circuit" annotation(Dialog(tab = "General", group = "HTF circuit"));
  parameter Modelica.SIunits.Volume Vhtf = 0.025 "Volume of HTF fluid" annotation(Dialog(tab = "General", group = "HTF circuit"));
  parameter Modelica.SIunits.Density rho_htf(displayUnit = "kg/m3") = 805 "Density of HTF fluid" annotation(Dialog(tab = "General", group = "HTF circuit"));
  parameter Modelica.SIunits.SpecificHeatCapacity chtf = 1525 "Specific heat capacity of HTF" annotation(Dialog(tab = "General", group = "HTF circuit"));
  parameter Modelica.SIunits.Temperature Thtf_init = 500 "Initial temperature of HTF" annotation(Dialog(tab = "General", group = "HTF circuit"));
  parameter Boolean useAmbientLoss = false "Parameter to choose if conduction loss to ambient should be included";
  parameter Modelica.SIunits.ThermalConductivity ktoambient = 2 "Thermal conductivity from HTF circuit to ambient" annotation(Dialog(tab = "General", group = "Heat loss"));
  parameter Modelica.SIunits.Area Atoambient = 0.2 "Heat transfer area from HTF circuit to ambient" annotation(Dialog(tab = "General", group = "Heat loss"));
  parameter Modelica.SIunits.Length ttoambient = 0.002 "Wall thickness from HTF circuit to ambient" annotation(Dialog(tab = "General", group = "Heat loss"));
  parameter Real HTC(unit = "W/m2-K") = 15750;
  //Components
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a storage_port "Heat port on storage side" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-91.865, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b workingGas_port annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {96.707, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ambientTemperature_port if useAmbientLoss annotation(Placement(visible = true, transformation(origin = {60, 95}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 41.578}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = Vhtf * rho_htf * chtf, T(start = Thtf_init)) annotation(Placement(visible = true, transformation(origin = {-10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conductionToAmbient(G = Atoambient * ktoambient / ttoambient) if useAmbientLoss "Conduction to ambient" annotation(Placement(visible = true, transformation(origin = {35, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HTFequivalentHeatConduction1(G = 2 * Ghtf) annotation(Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HTFequivalentHeatConduction2(G = 2 * Ghtf) annotation(Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput HTCc = HTC annotation(Placement(visible = true, transformation(origin = {107.5, -37.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = -360), iconTransformation(origin = {105.14, -16.535}, extent = {{-18.438, -18.438}, {18.438, 18.438}}, rotation = -360)));
equation
  connect(HTFequivalentHeatConduction2.port_b, workingGas_port) annotation(Line(visible = true, origin = {70, 0}, points = {{-30, 0}, {30, 0}}, color = {191, 0, 0}));
  connect(conductionToAmbient.port_b, ambientTemperature_port) annotation(Line(visible = true, origin = {55, 65}, points = {{-10, -15}, {5, -15}, {5, 30}}, color = {191, 0, 0}));
  connect(HTFequivalentHeatConduction1.port_a, storage_port) annotation(Line(visible = true, origin = {-70, 0}, points = {{30, 0}, {-30, 0}}, color = {191, 0, 0}));
  connect(HTFequivalentHeatConduction1.port_b, HTFequivalentHeatConduction2.port_a) annotation(Line(visible = true, points = {{-20, 0}, {20, 0}}, color = {191, 0, 0}));
  connect(conductionToAmbient.port_a, HTFequivalentHeatConduction2.port_a) annotation(Line(visible = true, origin = {19.75, 25}, points = {{5.25, 25}, {-2.75, 25}, {-2.75, -25}, {0.25, -25}}, color = {191, 0, 0}));
  connect(heatCapacitor.port, HTFequivalentHeatConduction1.port_b) annotation(Line(visible = true, origin = {-13.333, 13.333}, points = {{3.333, 26.667}, {3.333, -13.333}, {-6.667, -13.333}}, color = {191, 0, 0}));
  annotation(Documentation(info = "<p>Model of the heat transfer resistance in the pumping circuit in&nbsp;1D. Two conductors are placed on either side of a lumped mass (capacitor),&nbsp;between storage and engine. One additional conductor is placed between these two connecting the lumped mass to ambient.</p>
<p>The equations for heatCapacitor and the two thermalConductors are:</p>
<p><strong>Q_flow = G *dT</strong></p>
<p><strong>Q_flow = c * der(T) where der(T) = dT/dt</strong></p>", revisions = ""), experiment(__Wolfram_SynchronizeWithRealTime = false), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Text(visible = true, origin = {0, -60}, textColor = {149, 23, 41}, extent = {{-160, -37.317}, {160, 37.317}}, textString = "%name"), Rectangle(visible = true, origin = {1.239, 1.171}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-91.239, -35.805}, {91.239, 35.805}}, radius = 10), Line(visible = true, origin = {4.605, 2.015}, points = {{-90.389, -0.29}, {-70.422, -0.29}, {-48.424, 30.913}, {-14.605, -26.912}, {30.349, 30.153}, {59.731, -32.015}, {72.902, -0.29}, {85.395, -0.29}}, color = {177, 0, 0}, thickness = 4), Ellipse(visible = true, origin = {0, 2.036}, lineColor = {160, 160, 164}, fillColor = {149, 23, 41}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-35.957, -35.957}, {35.957, 35.957}}), Polygon(visible = true, origin = {8, -2.786}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-28, 30}, {-28, -20}, {22, 2.786}})}), Diagram(coordinateSystem(extent = {{-100, -80}, {100, 95}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end genericHeatResistance;
