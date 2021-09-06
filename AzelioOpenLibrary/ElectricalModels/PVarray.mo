within AzelioOpenLibrary.ElectricalModels;

model PVarray
  Modelica.Blocks.Interfaces.RealInput G_GHI(unit = "W/m2") "Global Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 45}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_DHI(unit = "W/m2") "Diffuse Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_DNI(unit = "W/m2") "Direct Normal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 65}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_Amb(unit = "degC") "Ambient temperature" annotation(Placement(visible = true, transformation(origin = {-155, 25}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Azim2(unit = "rad") "Solar Azimuth angle" annotation(Placement(visible = true, transformation(origin = {-155, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Elev(unit = "rad") "Solar Elevation angle" annotation(Placement(visible = true, transformation(origin = {-155, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput w(unit = "m/s") "Wind speed" annotation(Placement(visible = true, transformation(origin = {257.61, 29.472}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealOutput P_DC(unit = "W") "Gross DC power output" annotation(Placement(visible = true, transformation(origin = {129.728, 64.468}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput P_nom1(unit = "W") "Nominal power for capacity factor calcualtion" annotation(Placement(visible = true, transformation(origin = {121.161, -5.625}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Boolean Tracking = true "True for single-axis tracking E-W, false for fixed tilt";
  parameter Real Lat = 31.03 "Location latitude";
  parameter Real EASL(unit = "m") = 1140 "Elevation above sea level at location";
  parameter Real Alb = 0.2 "Ground albedo coefficient";
  parameter Real I_SC(unit = "A") = 6.39 "Shortcircuit current";
  parameter Real alpha_SC(unit = "A/K") = 0.0029 "Current coefficient";
  parameter Real NOCT(unit = "K") = 41.5 + 273.15 "Nominal Operational Cell Temperature";
  parameter Real eta_ref = 0.20 "Nominal module efficiency";
  parameter Real Ncell = 96 "Number of cells in series in the PV module";
  parameter Real P_mod(unit = "W") = 345 "Module nominal power";
  parameter Real I_darkref(unit = "A") = 2.437798 * 10e-11 "Reference dark saturation current";
  parameter Real P_nom(unit = "W") = 13110 "Array nominal AC power";
  parameter Real shad = 0.02 "Shading losses";
  parameter Real soil = 0.02 "Soiling losses";
  parameter Real mism = 0.02 "Mismatch losses";
  parameter Real cab = 0.02 "Cabling losses";
  constant Real nref = 1.526 "Effective index of refraction of the cell cover";
  constant Real K_gl(unit = "m-1") = 4 "Glazing extinction coefficient";
  constant Real L_gl(unit = "m") = 0.002 "Glazing thickness";
  constant Real e(unit = "C") = 1.60217662 * 10e-19 "Elementar charge";
  constant Real k(unit = "J/K") = Modelica.Constants.k "Boltzmann constant";
  Real Sun_Zen(unit = "rad") "Sun Zenith angle";
  Real PV_track(unit = "rad") "PV tracking axis angle";
  Real PV_Azim(unit = "rad") "PV azimuth angle";
  Real beta_ref(unit = "rad") "Reference tilt angle";
  Real beta_c(unit = "rad") "Actual collector Tilt";
  Real theta_b(unit = "rad") "Incidence angle";
  Real rot(unit = "rad") "Surface rotation angle about tracking axis";
  Real a "control value on incidence angle";
  Real cos_eff "Cosine effectiveness";
  Real G_b(unit = "W/m2") "Beam Irradiance on collector";
  Real G_d(unit = "W/m2") "Diffuse Irradiance on collector";
  Real G_g(unit = "W/m2") "Ground reflectes Irradiance on collector";
  Real G_Tot(unit = "W/m2") "Total Irradiance on collector";
  Real theta_d(unit = "rad") "Effective incidence of diffused irradiance";
  Real theta_g(unit = "rad") "Effective incidence of reflected irradiance";
  Real theta_r(unit = "rad") "Referemce angle, 1 deg";
  Real theta_tb(unit = "rad") "Refraction angle for beam irradiance";
  Real theta_td(unit = "rad") "Refraction angle for diffused irradiance";
  Real theta_tg(unit = "rad") "Refraction angle for ground reflected irradiance";
  Real theta_tr(unit = "rad") "Refraction angle for reference";
  Real trans_d_temp "Diffuse transmittance";
  Real trans_g_temp "Reflected transmittance";
  Real trans_b "Beam transmittance";
  Real trans_d "Diffuse transmittance";
  Real trans_g "Reflected transmittance";
  Real trans_0 "Reference transmittance";
  Real IAM_b "Incidence angle modifier for beam irradiance";
  Real IAM_d "Incidence angle modifier for diffused irradiance";
  Real IAM_g "Incidence angle modifier for ground reflected irradiance";
  Real AM "Air mass";
  Real M "Air mass modifier";
  Real G(unit = "W/m2") "Total useful irradiance on collector";
  Real taualpha "Transmittance-absorbance product";
  Real T_PV(unit = "K") "PV temperature";
  Real I_L(unit = "A") "Light current";
  Real E_bandgap(unit = "eV") "Energy band gap of material, considering silicon as reference";
  Real I_darksat(unit = "A") "Dark saturation current";
  Real v_exp "Exponent for V_MPP calculation";
  Real V_MPP(unit = "V") "MPP cell voltage";
  Real I_MPP(unit = "A") "MPP module/cell current";
  Real P_MPP_C(unit = "W") "MPP cell power";
  Real N_mod "Number of module in solar park";
  Real P_MPP_M(unit = "W") "MPP module power";
  Real E_DC(unit = "J", start = 0.0) "DC energy yield";
  Real Sun_Azim(unit = "rad");
equation
  Sun_Zen = 0.5 * Modelica.Constants.pi - Sun_Elev;
  if noEvent(Lat >= 0) then
    PV_track = Modelica.Constants.pi;
  else
    PV_track = 0;
  end if;
  // The following two lines are needed if input data is sparse and has jumps in azimuth angle (from 0 to 360 deg e.g.)
  if noEvent(der(Sun_Azim2) > 0.0001) then
    Sun_Azim = 2 * Modelica.Constants.pi;
  else
    Sun_Azim = Sun_Azim2;
  end if;
  if noEvent(abs(Lat) > 65) then
    beta_ref = Modelica.SIunits.Conversions.from_deg(0.224 * abs(Lat) + 33.6);
  else
    beta_ref = Modelica.SIunits.Conversions.from_deg(0.764 * abs(Lat) + 2.1);
  end if;
  if Tracking then
    rot = atan(tan(Sun_Zen) * sin(Sun_Azim - PV_track));
    beta_c = abs(rot);
    if noEvent(abs(beta_c) > 0) then
      PV_Azim = PV_track + asin(sin(rot) / sin(beta_c));
    else
      PV_Azim = PV_track;
    end if;
  else
    rot = 0;
    beta_c = beta_ref;
    PV_Azim = PV_track;
  end if;
  a = cos(beta_c) * cos(Sun_Zen) + sin(beta_c) * sin(Sun_Zen) * cos(Sun_Azim - PV_Azim);
  if noEvent(a < (-1)) then
    theta_b = Modelica.Constants.pi;
  elseif noEvent(a > 1) then
    theta_b = 0;
  else
    theta_b = acos(a);
  end if;
  cos_eff = cos(theta_b);
  G_b = G_DNI * cos(theta_b);
  G_d = 0.5 * G_DHI * (1 + cos(beta_c));
  G_g = 0.5 * G_GHI * Alb * (1 - cos(beta_c));
  G_Tot = G_b + G_d + G_g;
  theta_d = Modelica.SIunits.Conversions.from_deg(59.68 - 0.1388 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.001497 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_g = Modelica.SIunits.Conversions.from_deg(90.00 - 0.5788 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.002693 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_r = Modelica.SIunits.Conversions.from_deg(1);
  theta_tb = asin(sin(theta_b) / nref);
  theta_td = asin(sin(theta_d) / nref);
  theta_tg = asin(sin(theta_g) / nref);
  theta_tr = asin(sin(theta_r) / nref);
  if noEvent(theta_b > 0) then
    trans_b = exp(-K_gl * L_gl / cos(theta_tb)) * (1 - 0.5 * (sin(theta_tb - theta_b) ^ 2 / sin(theta_tb + theta_b) ^ 2 + tan(theta_tb - theta_b) ^ 2 / tan(theta_tb + theta_b) ^ 2));
  elseif noEvent(theta_b < 0) then
    trans_b = exp(-K_gl * L_gl / cos(theta_tb)) * (1 - 0.5 * (sin(theta_tb - theta_b) ^ 2 / sin(theta_tb + theta_b) ^ 2 + tan(theta_tb - theta_b) ^ 2 / tan(theta_tb + theta_b) ^ 2));
  else
    trans_b = 1;
  end if;
  trans_d_temp = exp(-K_gl * L_gl / cos(theta_td)) * (1 - 0.5 * (sin(theta_td - theta_d) ^ 2 / sin(theta_td + theta_d) ^ 2 + tan(theta_td - theta_d) ^ 2 / tan(theta_td + theta_d) ^ 2));
  trans_g_temp = exp(-K_gl * L_gl / cos(theta_tg)) * (1 - 0.5 * (sin(theta_tg - theta_g) ^ 2 / sin(theta_tg + theta_g) ^ 2 + tan(theta_tg - theta_g) ^ 2 / tan(theta_tg + theta_g) ^ 2));
  if noEvent(trans_d_temp < 0) then
    trans_d = 0;
  else
    trans_d = trans_d_temp;
  end if;
  if noEvent(trans_g_temp < 0) then
    trans_g = 0;
  else
    trans_g = trans_g_temp;
  end if;
  trans_0 = exp(-K_gl * L_gl / cos(theta_tr)) * (1 - 0.5 * (sin(theta_tr - theta_r) ^ 2 / sin(theta_tr + theta_r) ^ 2 + tan(theta_tr - theta_r) ^ 2 / tan(theta_tr + theta_r) ^ 2));
  IAM_b = trans_b / trans_0;
  IAM_d = trans_d / trans_0;
  IAM_g = trans_g / trans_0;
  if noEvent(Sun_Zen >= Modelica.SIunits.Conversions.from_deg(86)) then
    AM = (cos(Modelica.SIunits.Conversions.from_deg(86)) + 0.5057 * (96.080 - 86) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  elseif noEvent(Sun_Zen <= 0) then
    AM = (1 + 0.5057 * 96.080 ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  else
    AM = (cos(Sun_Zen) + 0.5057 * (96.080 - Modelica.SIunits.Conversions.to_deg(Sun_Zen)) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  end if;
  M = 0.918093 + 0.086257 * AM - 0.024459 * AM ^ 2 + 0.002816 * AM ^ 3 - 0.000126 * AM ^ 4;
  G = M * (G_b * IAM_b + G_d * IAM_d + G_g * IAM_g);
  if noEvent(G_Tot > 0) then
    taualpha = 0.9 * (G_b * IAM_b + G_d * IAM_d + G_g * IAM_g) / G_Tot;
    T_PV = T_Amb + 273.15 + (NOCT - 293.15) * G / 800 * (1 - eta_ref / taualpha) * 9.5 / (5.7 + 3.8 * 0.51 * w);
  else
    taualpha = 0;
    T_PV = T_Amb + 273.15;
  end if;
  I_L = G * (I_SC + alpha_SC * (T_PV - 298.15)) / 1000;
  E_bandgap = 1.121 * (1 - 0.0002677 * (T_PV - 298.15));
  I_darksat = I_darkref * (T_PV / 298.15) ^ 3 * exp((1.121 / 298.15 - E_bandgap / T_PV) / (8.6173303 * 10e-5));
  v_exp = e * 0.1 * V_MPP / (k * T_PV);
  //exp(v_exp) = (1 + I_L / I_darksat) / (1 + v_exp);
  (1 + v_exp) * exp(v_exp) = 1 + I_L / I_darksat;
  I_MPP = e * V_MPP * (I_L + I_darksat) / (k * T_PV + e * V_MPP);
  P_MPP_C = V_MPP * I_MPP;
  P_MPP_M = V_MPP * I_MPP * Ncell;
  N_mod = P_nom / P_mod;
  P_DC = P_MPP_M * N_mod * (1 - shad) * (1 - soil) * (1 - mism) * (1 - cab);
  P_DC = der(E_DC);
  P_nom1 = P_nom;
  annotation(Documentation(info = "<p>This model simulates the power output <em>P<sub>DC&nbsp;</sub></em>(W)&nbsp;and energy yield <em>E<sub>DC</sub></em> (J)&nbsp;of a solar park, based on NREL SAM procedure [1], using the following TMY data for a given location, when latitude and elevation above sea level <em>EASL</em> (m)&nbsp;are known:</p>
<ul>
<li>Global Horizontal Irradiance <em>G<sub>GHI</sub></em> (W/m<sup>2</sup>);</li>
<li>Diffuse Horizontal Irradiance <em>G<sub>DHI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Direct Normal Irradiance<em> G<sub>DNI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Ambient temperature <em>T<sub>Amb</sub></em> (&deg;C);</li>
<li>Solar azimuth angle <em>Azim<sub>Sun</sub></em> (rad);</li>
<li>Solar elevation angle <em>Elev<sub>Sun</sub></em> (rad);</li>
<li>Wind speed <em>w</em> (m/s).</li>
</ul>
<p>Regarding the PV module, it is necessary to know the following values, available from manufacturer datasheet:</p>
<ul>
<li>Short circuit current <em>I<sub>SC</sub></em> (A);</li>
<li>Current-temeperature coefficient <span style=\"font-family: symbol;\"><em>a</em></span>&nbsp;(A/K);</li>
<li>Nominal Operational Cell Temperature T<sub>NOCT</sub> (&deg;C);</li>
<li>Reference efficiency <span style=\"font-family: symbol;\">h</span>;</li>
<li>Number of soalr cells in a module <em>N<sub>cell</sub></em>;</li>
<li>Nominal module power <em>P<sub>nom</sub></em> (W).</li>
</ul>
<p>Firstly, it is necessary to select if the system includes a single-axis tracking system, to improve performance. This is done by selecting the boolean value \"true\" for the boolean variable \"Tracking\".</p>
<p>All angles are calculated in radians and all the temperatures are converted to Kelvin. Sun Zenith <em>Zen<sub>Sun</sub></em> (rad)&nbsp;is determined as complementary angle of the solar elevation. The tracking axis angle <em>Track<sub>PV</sub></em> (rad) is assumed to be either zero (Southern Hemisphere) or pi (Northern Hemisphere). In addition, a fix for sparse azimuth angle data is included and it redefines tha azimth angle to be zero if the time derivative of the azimuth angle is &gt; 0.0005 (which occurs as the angle jumps from close to zero to close to 360).</p>
<p>Depending on the tracking system, the tilt angle of the collectors <em><span style=\"font-family: symbol;\">b</span><sub>c</sub></em> (rad), the rotation of the tracking angle <em>rot</em> (rad)&nbsp;and the actual collector azimuth angle <em>Azim<sub>PV</sub></em> (rad)&nbsp;are determined.</p>
<table style=\"height: 159px; margin-left: auto; margin-right: auto;\" width=\"439\">
<tbody>
<tr>
<td><strong>Fixed tilt&nbsp;</strong></td>
<td style=\"text-align: left;\"><strong>Single axis tracking</strong></td>
</tr>
<tr>
<td><em>rot = 0</em></td>
<td style=\"text-align: left;\"><em>rot = atan(tan(Zen<sub>Sun</sub>)&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot;&nbsp;</span></span>sin(Azim<sub>Sun</sub> - Azim<sub>PV</sub>))</em></td>
</tr>
<tr>
<td><em><span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>= f(Lat)</em></td>
<td style=\"text-align: left;\"><em>&nbsp;<span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>=&nbsp;abs(rot)</em></td>
</tr>
<tr>
<td><em>Azim<sub>PV</sub> = Track<sub>PV</sub></em></td>
<td style=\"text-align: left;\"><em>&nbsp;Azim<sub>PV</sub> = Track<sub>PV</sub> + asin(sin(rot) / sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>))</em></td>
</tr>
</tbody>
</table>
<p>At this point, the incidence angle <em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>&nbsp;(rad) and cosine efficiency cos(<em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>)&nbsp;can be calculated:&nbsp;</p>
<p><em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b&nbsp;</span></sub><span style=\"font-family: verdana, geneva;\">= acos(cos(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; cos(Zen<sub>Sun</sub>) + sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; sin(Zen<sub>Sun</sub>)&nbsp;&middot; cos(Azim<sub>Sun&nbsp;</sub>- Azim<sub>PV</sub>))</span></span></em></p>
<p>Referring to [1], actual incidence angles for beam <em>G<sub>b </sub></em>(W), diffuse <em>G<sub>d</sub>&nbsp;</em>(W) and global irradiance <em>G<sub>g</sub></em>&nbsp;(W) are determined by&nbsp;multiplying TMY&nbsp;irradiance with incidence angle modifiers <em>IAM<sub>b</sub></em>, <em>IAM<sub>d</sub></em> and <em>IAM<sub>g</sub></em>&nbsp;based on trasmittance and optical properties of glass.&nbsp;</p>
<p>Air mass <em>AM</em> is determined and from it the air mass modifier coefficient <em>M</em> can be derived and used to finally obtain the usefuyl irradiance on the tilted collector <em>G</em> (W).</p>
<p><em>G = M&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot; (G<sub>b</sub>&nbsp;&middot; IAM<sub>b</sub> + G<sub>d</sub>&nbsp;&middot; IAM<sub>d</sub> + G<sub>g</sub>&nbsp;&middot; IAM<sub>g</sub>)</span></span></em></p>
<p>By introducing the transmittance-absorbance product <span style=\"font-family: symbol;\">ta</span>, the actual cell temperature is determined as function of this latest parameter, useful irradiance, reference current value, temperatures, wind speed and reference irradiance:</p>
<p><em>T<sub>PV</sub> = T<sub>Amb</sub> + (T<sub>NOCT</sub> - 293.15)</em>&nbsp;<em>&middot; (G / 800) &middot; (1 - <span style=\"font-family: symbol;\">h/ta</span>) &middot; (9.5 / ( 5.7 + 3.8&nbsp;&middot; 0.51&nbsp;&middot; w))</em></p>
<p>Subsequently, light current <em>I<sub>L</sub></em> (A), actual energy bandgap <em>E<sub>bg</sub></em> (eV) and dark saturation current <em>I<sub>darksat</sub></em> (A)&nbsp;are deteremined according to De Soto equations, used in [1].</p>
<p><em>I<sub>L</sub> = G&nbsp;&middot; (I<sub>SC</sub> + <span style=\"font-family: symbol;\">a</span> &middot; (T<sub>PV</sub> - 298.15)) / 1000</em></p>
<p><em>E<sub>bg</sub> = 1.121&nbsp;&middot; (1 - 0.000267&nbsp;&middot; (T<sub>PV</sub> - 298.15))</em></p>
<p><em>I<sub>darksat</sub> = I<sub>dark ref</sub> &middot; (T<sub>PV</sub>/298.15)<sup>3</sup> &middot; exp(((1.121 / &nbsp;298.15) - (E<sub>bg</sub>/ T<sub>PV</sub>)) / (8.6173303 &middot;10<sup>-5</sup>))</em></p>
<p><em>exp(e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)) = (1 + I<sub>L</sub>/I<sub>darksat</sub>) / (1 + (e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)))&nbsp;</em></p>
<p><em>IMPP =&nbsp;e &middot; V<sub>MPP</sub> &middot; (I<sub>L</sub> + I<sub>darksat</sub>) / (k &middot; T<sub>PV </sub>+ e &middot; V<sub>MPP</sub><span style=\"font-size: xx-small;\">)</span></em></p>
<p>Once maximum power point voltage <em>V<sub>MPP</sub></em> (V) and current <em>I<sub>MPP</sub></em> (A)&nbsp;are determined, the DC power output from a single cell, module <em>P<sub>MPP,M</sub></em>&nbsp;(W) and then for the entire solar park are calcualted, as well as the gross, DC energy yield, by introducing losses due to DC cables, mismatiching, shadowing and soiling.</p>
<p><em>P<sub>MPP,M</sub> = V<sub>MPP</sub> &middot; I<sub>MPP</sub> &middot; N<sub>cell</sub></em></p>
<p><em>P<sub>DC</sub> = P<sub>MPP,M</sub> &middot; N<sub>mod</sub> &middot; (1 - shad) &middot; (1 - soil) &middot; (1 - mism)&nbsp; &middot; (1 - cab)</em></p>
<p><em>d(P<sub>DC</sub>)/dt = E<sub>DC</sub></em></p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Polygon(visible = true, origin = {0.297, -48.095}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, lineThickness = 2.5, points = {{-4.305, 21.377}, {-4.305, 0.67}, {-14.769, -1.905}, {-14.769, -11.905}, {-0.297, -17.142}, {14.843, -11.905}, {14.843, -1.905}, {4.379, 1.338}, {4.379, 21.377}}), Rectangle(visible = true, origin = {0, 20}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, lineThickness = 2.5, extent = {{-50, -50}, {50, 50}}), Line(visible = true, origin = {-40, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-30, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-20, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {-10, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {10, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {30, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {40, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {20, 20}, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 60}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 50}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 40}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 30}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 20}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, 10}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -10}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, origin = {0, -20}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5), Line(visible = true, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {255, 255, 255}, thickness = 2.5)}), experiment(__Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end PVarray;
