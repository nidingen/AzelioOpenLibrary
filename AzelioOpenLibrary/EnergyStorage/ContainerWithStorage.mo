within AzelioOpenLibrary.EnergyStorage;

model ContainerWithStorage "Container with latent heat storage"
  //Parameters
  parameter Modelica.SIunits.Mass m1 = 3960 "Mass of storage material" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Modelica.SIunits.Temperature Tref1 = 288.15 "Temperature of storage at which enthalpy is zero." annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Modelica.SIunits.Temperature Tm1 = 850.15 "Melting temperature" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Modelica.SIunits.SpecificEnthalpy hm1 = 477689.07 "Latent heat" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Modelica.SIunits.TemperatureDifference Toffset1 = 0.25 "Temperature offset" annotation(Dialog(tab = "Storage", group = "Numerical cheating"));
  parameter Modelica.SIunits.Temperature Tinit = 850.15 "Initial temperature" annotation(Dialog(tab = "Storage", group = "Initialization"));
  parameter Modelica.SIunits.SpecificHeatCapacity cL = 1100 "Specific heat capacity of liquid phase" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Modelica.SIunits.Area Ahtfw = 4 "Area of htf side wall" annotation(Dialog(tab = "Conduction", group = "HTF side"));
  parameter Modelica.SIunits.ThermalConductivity khtfw = 16 "Thermal conductivity of htf side wall" annotation(Dialog(tab = "Conduction", group = "HTF side"));
  parameter Modelica.SIunits.Length thtfw = 0.002 "Thickness of htf side wall" annotation(Dialog(tab = "Conduction", group = "HTF side"));
  parameter Modelica.SIunits.Area Arecw = 1.13 "Area of receiver side wall" annotation(Dialog(tab = "Conduction", group = "Receiver side"));
  parameter Modelica.SIunits.ThermalConductivity krecw = 16 "Thermal conductivity of receiver side wall" annotation(Dialog(tab = "Conduction", group = "Receiver side"));
  parameter Modelica.SIunits.Length trecw = 0.003 "Thickness of receiver side wall" annotation(Dialog(tab = "Conduction", group = "Receiver side"));
  parameter Boolean useAmbientLoss = true "Parameter to choose if conduction loss to ambient should be included";
  parameter Modelica.SIunits.Area Aambw = 11.5 "Area of ambient side wall" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  parameter Modelica.SIunits.ThermalConductivity kambw = 16 "Thermal conductivity of ambient side wall" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  parameter Modelica.SIunits.Length tambw = 0.002 "Thickness of ambient side wall" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  parameter Modelica.SIunits.Area Aambis = 11.5 "Area of ambient side insulation" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  parameter Modelica.SIunits.ThermalConductivity kambis = 0.11 "Thermal conductivity of ambient side insulation" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  parameter Modelica.SIunits.Length tambis = 0.275 "Thickness of ambient side insulation" annotation(Dialog(tab = "Conduction", group = "Ambient side"));
  Modelica.SIunits.Energy Etostorage(start = 0, fixed = false, displayUnit = "kWh");
  Modelica.SIunits.Energy Efromstorage(start = 0, fixed = false, displayUnit = "kWh");
  Real E_from_storage(unit = "J", start = 0, fixed = false, displayUnit = "kWh");
  Real Q_from_storage(unit = "W", displayUnit = "MW") = -port_to_HTF.Q_flow;
  Real Q_to_storage(unit = "W", displayUnit = "MW") = port_from_receiver_cavity.Q_flow;
  //Components
  EnergyStorage.GenericLatentStorage GenericLatentStorage(Cs_0 = cS_0, Cs_1 = cS_1, Cs_2 = cS_2, m = m1, Tref = Tref1, Tm = Tm1, hm = hm1, cL = cL, T.start = Tinit, T.fixed = false, der_T.fixed = false, Toffset = Toffset1, Cs_3 = Cs_3) annotation(Placement(visible = true, transformation(origin = {-0, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor containerHTFwall(G = Ahtfw * khtfw / thtfw) "Storage container wall conduction resistance" annotation(Placement(visible = true, transformation(origin = {80, -0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor containerReceiverWall1(G = Arecw * krecw / (0.5 * trecw)) "Storage container wall conduction resistance" annotation(Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor containerAmbientWall(G = Aambw * kambw / tambw) if useAmbientLoss "Storage container wall conduction resistance" annotation(Placement(visible = true, transformation(origin = {-0, 30}, extent = {{10, -10}, {-10, 10}}, rotation = -270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor containerAmbientInsulation(G = Aambis * kambis / tambis) if useAmbientLoss "Storage container insulation conduction resistance" annotation(Placement(visible = true, transformation(origin = {-0, 70}, extent = {{10, -10}, {-10, 10}}, rotation = -270)));
  //Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_to_HTF "Heat port to HTF circuit" annotation(Placement(visible = true, transformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99.989, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_from_receiver_cavity "Heat port from receiver cavity" annotation(Placement(visible = true, transformation(origin = {-150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101.01, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_to_ambient if useAmbientLoss "Heat port to ambient" annotation(Placement(visible = true, transformation(origin = {0, 105}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor containerReceiverWall2(G = Arecw * krecw / (0.5 * trecw)) "Storage container wall conduction resistance" annotation(Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real cS_0(unit = "J/(kg.K)") = -519.55379 "Constant coefficient for Cs = f(T) calculations (GenericLatentStorage.Cs_0)" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Real cS_1(unit = "J/(kg.K2)") = 3.66575 "First-grade coefficient for Cs = f(T) calculations (GenericLatentStorage.Cs_1)" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Real cS_2(unit = "J/(kg.K3)") = -0.00189 "Second-grade coefficient for Cs = f(T) calculations (GenericLatentStorage.Cs_2)" annotation(Dialog(tab = "Storage", group = "Material properties"));
  parameter Real Cs_3 = 0 "Third-grade coefficient for Cs = f(T) calculations (GenericLatentStorage.Cs_3)" annotation(Dialog(tab = "Storage", group = "Material properties"));
  Real E_amblosses(unit = "J");
equation
  der(Etostorage) = port_from_receiver_cavity.Q_flow;
  der(Efromstorage) = port_to_HTF.Q_flow;
  Q_from_storage = der(E_from_storage);
  der(E_amblosses) = -port_to_ambient.Q_flow;
  connect(GenericLatentStorage.heatPort, containerHTFwall.port_b) annotation(Line(visible = true, origin = {23.333, -12.166}, points = {{-23.333, -24.332}, {-23.333, 12.166}, {46.667, 12.166}}, color = {191, 0, 0}, thickness = 0.5));
  connect(GenericLatentStorage.heatPort, containerAmbientWall.port_b) annotation(Line(visible = true, origin = {-0, -8.249}, points = {{-0, -28.249}, {0, 28.249}}, color = {191, 0, 0}));
  connect(containerHTFwall.port_a, port_to_HTF) annotation(Line(visible = true, origin = {120, -0}, points = {{-30, -0}, {30, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(port_from_receiver_cavity, containerReceiverWall1.port_a) annotation(Line(visible = true, origin = {-127.366, -10}, points = {{-22.634, 10}, {7.366, 10}}, color = {191, 0, 0}, thickness = 0.5));
  connect(port_to_ambient, containerAmbientInsulation.port_a) annotation(Line(visible = true, origin = {-0, 92.5}, points = {{0, 12.5}, {-0, -12.5}}, color = {191, 0, 0}));
  connect(containerAmbientInsulation.port_b, containerAmbientWall.port_a) annotation(Line(visible = true, origin = {-0, 50}, points = {{0, 10}, {0, -10}}, color = {191, 0, 0}));
  connect(containerReceiverWall1.port_b, containerReceiverWall2.port_a) annotation(Line(visible = true, origin = {-80.772, -38.087}, points = {{-19.228, 38.087}, {2.772, 38.087}, {20.772, 38.087}}, color = {191, 0, 0}, thickness = 0.5));
  connect(containerReceiverWall2.port_b, GenericLatentStorage.heatPort) annotation(Line(visible = true, origin = {-13.333, -12.166}, points = {{-26.667, 12.166}, {13.333, 12.166}, {13.333, -24.332}}, color = {191, 0, 0}, thickness = 0.5));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Polygon(visible = true, origin = {0, -10}, lineColor = {149, 23, 41}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, points = {{-80, 80}, {-70, 80}, {70, 80}, {80, 80}, {80, 60}, {70, -37.936}, {70, -60}, {50, -60}, {-50, -60}, {-70, -60}, {-70, -40}, {-80, 60}}, smooth = Smooth.Bezier), Text(visible = true, origin = {0, 50}, textColor = {255, 255, 255}, extent = {{-87.213, -23.671}, {87.213, 23.671}}, textString = "Container", fontSize = 92, textStyle = {TextStyle.Bold}), Text(visible = true, origin = {1.806, 19.528}, textColor = {255, 255, 255}, extent = {{-91.806, -20.472}, {91.806, 20.472}}, textString = "with", fontSize = 92, textStyle = {TextStyle.Bold}), Text(visible = true, origin = {2.196, -10.005}, textColor = {255, 255, 255}, extent = {{-89.666, -19.995}, {89.666, 19.995}}, textString = "Latent", fontSize = 92, textStyle = {TextStyle.Bold}), Text(visible = true, origin = {4.475, -43.618}, textColor = {255, 255, 255}, extent = {{-95.525, -18.568}, {95.525, 18.568}}, textString = "Storage", fontSize = 92, textStyle = {TextStyle.Bold})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end ContainerWithStorage;
