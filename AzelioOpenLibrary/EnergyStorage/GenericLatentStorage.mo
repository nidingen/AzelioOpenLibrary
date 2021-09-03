within AzelioOpenLibrary.EnergyStorage;

model GenericLatentStorage "Generic latent heat storage model based on temperature; C is set in if-statement."
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 45.009}, extent = {{-13.423, -13.423}, {13.423, 13.423}}, rotation = 0)));
  parameter Modelica.SIunits.Mass m = 3960 "Mass of storage material" annotation(Dialog(tab = "General", group = "Mass"));
  parameter Modelica.SIunits.Temperature Tref = 288.15 "Temperature of storage at which enthalpy is zero." annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Modelica.SIunits.Temperature Tm = 850.15 "Melting temperature" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Modelica.SIunits.SpecificEnthalpy hm = 477689.07 "Latent heat" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Modelica.SIunits.TemperatureDifference Toffset = 0.25 "Temperature offset" annotation(Dialog(tab = "General", group = "Numerical cheating"));
  parameter Real Cs_0(unit = "J/(kg.K)") = -519.55379 "Constant coefficient for Cs = f(T) calculations" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Real Cs_1(unit = "J/(kg.K2)") = 3.66575 "First-grade coefficient for Cs = f(T) calculations" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Real Cs_2(unit = "J/(kg.K3)") = -0.00189 "Second-grade coefficient for Cs = f(T) calculations" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Real Cs_3(unit = "J/(kg.K4)") = 0 "Third-grade coefficient for Cs = f(T) calculations" annotation(Dialog(tab = "General", group = "Material properties"));
  //parameter Modelica.SIunits.SpecificHeatCapacity cS "Specific heat capacity of solid phase" annotation(Dialog(tab = "General", group = "Material properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity cL = 1100 "Specific heat capacity of liquid phase" annotation(Dialog(tab = "General", group = "Material properties"));
  Modelica.SIunits.TemperatureSlope der_T(start = 0) "Time derivative of temperature (= der(T))";
  Modelica.SIunits.Temperature T(fixed = true);
  //Modelica.SIunits.ThermalConductance C(start = 1.23, fixed = false);
  Real C(unit = "J/K", start = 1.23, fixed = false);
algorithm
  if T < Tm - Toffset then
    C := (Cs_0 + T * Cs_1 + T ^ 2 * Cs_2 + T ^ 3 * Cs_3) * m;
  elseif T > Tm + Toffset then
    C := cL * m;
  else
    C := hm / (2 * Toffset) * m;
  end if;
equation
  heatPort.T = T;
  der_T = der(T);
  C * der(T) = heatPort.Q_flow;
  annotation(Documentation(info = "<html><div>
<p>Model of PCM storage, with a total capacity of 550 kWh and an energy density of &nbsp;q<sub>tot</sub> = 500 kJ/kg between 570 degC and 590 degC. This latest value is the sum of both sensible (solid and liquid phase) and latent heat. The PCM theoretically melts at 577 degC, but a small delta T is introduced with the variable Toffset (default value 0.25degC).</p>
</div>
<div>
<p>Specific heat during solid phase is calculated as function of temperature [K]:</p>
</div>
<div>
<p>c<sub>S</sub>(T) = 0&nbsp;&middot; T<sup>3</sup>&nbsp;- 0.00189 &middot; T<sup>2</sup>&nbsp;+ 3.66575 &middot;&nbsp;T - 519.55379</p>
</div>
<div>
<p>Note that different correlations can be used, therefore it is possible to modify the coefficients (set as parameters).</p>
<p>Specific heat at liquid phase is assumed constant and equal to 1100 J/(kg K) as default.</p>
</div>
<div>
<p>Required latent heat is calculated as:</p>
</div>
<div>
<p>q<sub>tot</sub> = q<sub>sol</sub> + q<sub>lat</sub> + q<sub>liq</sub> = c<sub>S</sub>(average)&nbsp;&middot; (576.75-570) + q<sub>lat</sub> + c<sub>liq</sub> &middot; (590 - 577.25)</p>
</div>
<div>
<p>q<sub>lat</sub> = 477.689 kJ/kg</p>
</div>
<div>
<p>corresponding to 3960 kg of PCM, where cS(average) was calculated as:</p>
</div>
<div>
<p>c<sub>S</sub>(average) = [&int;c<sub>S</sub>(T)dT]/(576.75-570)</p>
</div>
<div>
<p>&nbsp;</p>
</div>
<div>
<p>&nbsp;</p>
</div></html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {1.989, -18.484}, lineColor = {0, 0, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.VerticalCylinder, extent = {{-83.879, -64.343}, {83.879, 64.343}}, radius = 5), Text(visible = true, origin = {2.733, -17.325}, textColor = {255, 255, 255}, extent = {{-67.267, -42.675}, {67.267, 42.675}}, textString = "Latent", textStyle = {TextStyle.Bold})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end GenericLatentStorage;
