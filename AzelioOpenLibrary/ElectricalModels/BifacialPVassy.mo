within AzelioOpenLibrary.ElectricalModels;

model BifacialPVassy
  Modelica.Blocks.Interfaces.RealInput G_F(unit = "W/m2") "Usueful irradiance on front" annotation(Placement(visible = true, transformation(origin = {-64.801, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-50, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -450)));
  Modelica.Blocks.Interfaces.RealInput G_R(unit = "W/m2") "Usueful irradiance on rear" annotation(Placement(visible = true, transformation(origin = {-50, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -270), iconTransformation(origin = {-50, -100}, extent = {{-20, -20}, {20, 20}}, rotation = -630)));
  Modelica.Blocks.Interfaces.RealInput G_F_Tot(unit = "W/m2") "Total irradiance on front" annotation(Placement(visible = true, transformation(origin = {-10, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -450)));
  Modelica.Blocks.Interfaces.RealInput G_R_Tot(unit = "W/m2") "Total irradiance on rear" annotation(Placement(visible = true, transformation(origin = {30, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -270), iconTransformation(origin = {50, -100}, extent = {{-20, -20}, {20, 20}}, rotation = -630)));
  Modelica.Blocks.Interfaces.RealInput M "Air mass modifier" annotation(Placement(visible = true, transformation(origin = {40, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {50, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput T_Amb(unit = "degC") "AMbient temperature at location" annotation(Placement(visible = true, transformation(origin = {-110, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput w(unit = "m/s") "Wind speed at location" annotation(Placement(visible = true, transformation(origin = {-110, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput P_DC(unit = "W") "DC array power output" annotation(Placement(visible = true, transformation(origin = {110, 55.037}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput E_DC(unit = "J") "DC array energy yield" annotation(Placement(visible = true, transformation(origin = {110, 14.753}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput P_nom1 annotation(Placement(visible = true, transformation(origin = {110, 34.927}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real BF = 0.65 "Bifaciality factor";
  parameter Real I_SC(unit = "A") = 6.39 "Shortcircuit current";
  parameter Real alpha_SC(unit = "A/K") = 0.00085 "Current coefficient";
  parameter Real NOCT(unit = "K") = 44.5 + 273.15 "Nominal Operational Cell Temperature";
  parameter Real Ncell = 96 "Number of cells in series in the PV module";
  parameter Real P_mod(unit = "W") = 345 "Nominal module power";
  parameter Real P_nom(unit = "W") = 13110 "Rated DC power of plant";
  parameter Real shad "Shading losses";
  parameter Real soil "Soiling losses";
  parameter Real mism "Mismatch losses";
  parameter Real cab "Cabling losses";
  constant Real e(unit = "C") = 1.60217662 * 10e-19 "Elementar charge";
  constant Real k(unit = "J/K") = Modelica.Constants.k "Boltzmann constant";
  Real G(unit = "W/m2") "Front + rear useful irradiance";
  Real G_Tot(unit = "W/m2") "Front + rear total irradiance";
  Real eta_ref "Temperature parameter";
  Real taualpha "Irradiance parameter";
  Real T_PV(unit = "K") "PV temperature";
  Real E_bandgap(unit = "eV") "Energy band gap of material, considering silicon as reference";
  Real I_darksat(unit = "A") "Dark saturation current";
  Real I_L(unit = "A") "Light current";
  Real v_exp "Exponent for V_MPP calculation";
  Real V_MPP(unit = "V") "MPP cell voltage";
  Real I_MPP(unit = "A") "MPP module/cell current";
  Real P_MPP_M(unit = "W") "MPP module power";
  Real N_mod "Number of modules in plant";
equation
  G_Tot = G_F_Tot + BF * G_R_Tot;
  G = G_F + BF * G_R;
  eta_ref = 6.02 * 57.3 / (1000 * 1.63);
  taualpha = if noEvent(G_Tot > 0 or G_Tot < 0) then 0.9 * (G / M) / G_Tot else 0;
  T_PV = if noEvent(taualpha > 0 or taualpha < 0) then T_Amb + 273.15 + (NOCT - 293.15) * G / 800 * ((taualpha - eta_ref) / taualpha) * 9.5 / (5.7 + 3.8 * 0.51 * w) else T_Amb + 273.15;
  I_L = G * (I_SC + alpha_SC * (T_PV - 298.15)) / 1000;
  E_bandgap = 1.121 * (1 - 0.0002677 * (T_PV - 298.15));
  I_darksat = 2.437798 * 10e-11 * (T_PV / 298.15) ^ 3 * exp((1.121 / 298.15 - E_bandgap / T_PV) / (8.6173303 * 10e-5));
  v_exp = e * 0.1 * V_MPP / (k * T_PV);
  exp(v_exp) = (1 + I_L / I_darksat) / (1 + v_exp);
  I_MPP = e * V_MPP * (I_L + I_darksat) / (k * T_PV + e * V_MPP);
  P_MPP_M = V_MPP * I_MPP * Ncell;
  N_mod = P_nom / P_mod;
  P_DC = P_MPP_M * N_mod * (1 - shad) * (1 - soil) * (1 - mism) * (1 - cab);
  P_DC = der(E_DC);
  P_nom1 = P_nom;
  annotation(Documentation(info = "<p>This block combines rear and front irradiance to calculate the total irradiance and the DC power output from the bifacial module and array.</p>
<p><em>G = G<sub>Front</sub> + BF &middot; G<sub>Rear</sub></em></p>
<p>where BF is the bifaciality factor from moulde data sheet.&nbsp;</p>
<p>By introducing the transmittance-absorbance product <em>ta</em>, the actual cell temperature is determined as function of this latest parameter, useful irradiance, reference current value, temperatures, wind speed and reference irradiance:</p>
<p><em>T<sub>PV</sub> = T<sub>Amb</sub> + (T<sub>NOCT</sub> - 293.15)</em>&nbsp;<em>&middot; (G / 800) &middot; (1 - h/ta) &middot; (9.5 / ( 5.7 + 3.8&nbsp;&middot; 0.51&nbsp;&middot; w))</em></p>
<p>Subsequently, light current <em>I<sub>L</sub></em> (A), actual energy bandgap <em>E<sub>bg</sub></em> (eV) and dark saturation current <em>I<sub>darksat</sub></em> (A)&nbsp;are deteremined according to De Soto equations, used in [1].</p>
<p><em>I<sub>L</sub> = G&nbsp;&middot; (I<sub>SC</sub> + a &middot; (T<sub>PV</sub> - 298.15)) / 1000</em></p>
<p><em>E<sub>bg</sub> = 1.121&nbsp;&middot; (1 - 0.000267&nbsp;&middot; (T<sub>PV</sub> - 298.15))</em></p>
<p><em>I<sub>darksat</sub> = I<sub>dark ref</sub> &middot; (T<sub>PV</sub>/298.15)<sup>3</sup> &middot; exp(((1.121 / &nbsp;298.15) - (E<sub>bg</sub>/ T<sub>PV</sub>)) / (8.6173303 &middot;10<sup>-5</sup>))</em></p>
<p><em>exp(e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)) = (1 + I<sub>L</sub>/I<sub>darksat</sub>) / (1 + (e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)))&nbsp;</em></p>
<p><em>IMPP =&nbsp;e &middot; V<sub>MPP</sub> &middot; (I<sub>L</sub> + I<sub>darksat</sub>) / (k &middot; T<sub>PV </sub>+ e &middot; V<sub>MPP</sub>)</em></p>
<p>Once maximum power point voltage <em>V<sub>MPP</sub></em> (V) and current <em>I<sub>MPP</sub></em> (A)&nbsp;are determined, the DC power output from a single cell, module<em>P<sub>MPP,M</sub></em>&nbsp;(W) and then for the entire solar park are calcualted, as well as the gross, DC energy yield, by introducing losses due to DC cables, mismatiching, shadowing and soiling.</p>
<p><em>P<sub>MPP,M</sub> = V<sub>MPP</sub> &middot; I<sub>MPP</sub> &middot; N<sub>cell</sub></em></p>
<p>&nbsp;</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Text(visible = true, origin = {1.781, 43.194}, textColor = {149, 23, 41}, extent = {{-70, -35}, {70, 35}}, textString = "FRONT", textStyle = {TextStyle.Italic, TextStyle.Bold}), Text(visible = true, origin = {-2.019, -37.39}, textColor = {149, 23, 41}, extent = {{-70, -35}, {70, 35}}, textString = "REAR", textStyle = {TextStyle.Italic, TextStyle.Bold}), Text(visible = true, origin = {-0, 5}, textColor = {149, 23, 41}, extent = {{-70, -35}, {70, 35}}, textString = "+", textStyle = {TextStyle.Italic, TextStyle.Bold})}));
end BifacialPVassy;
