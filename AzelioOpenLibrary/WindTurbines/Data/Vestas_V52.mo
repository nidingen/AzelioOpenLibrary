within AzelioOpenLibrary.WindTurbines.Data;

model Vestas_V52
  Modelica.Blocks.Tables.CombiTable1Ds cp_data(table = {{0, 0}, {3.75, 0}, {4, 0.10942983422648}, {4.5, 0.18965142222803}, {5, 0.233645068491674}, {5.5, 0.275394669325646}, {6, 0.288929997723483}, {6.5, 0.296255256287935}, {7, 0.292334931274774}, {7.5, 0.310132718798109}, {8, 0.310751900267731}, {8.5, 0.3164215762407}, {9, 0.31811748236937}, {9.5, 0.308853631082147}, {10, 0.304687253209085}, {10.5, 0.301704465008772}, {11, 0.297620312940685}, {11.5, 0.28670309587077}, {12, 0.271374599672595}, {12.5, 0.256937495314447}, {13, 0.244463774095767}, {13.5, 0.231661824426788}, {14, 0.218018474295986}, {14.5, 0.202439513831148}, {15, 0.18639579572279}, {15.5, 0.172768846195409}, {16, 0.159535124678423}, {16.5, 0.145466982927417}, {17, 0.133005469302426}, {17.5, 0.12192762601662}, {18, 0.112046617058097}, {18.5, 0.103205080952018}, {19, 0.0952698455580728}, {19.5, 0.0881276988058222}, {20, 0.0816819838353526}, {20.5, 0.0758498420722649}, {21, 0.0705599687596179}, {21.5, 0.0657507762267796}, {22, 0.0613688834225039}, {22.5, 0.0573678679337456}, {23, 0.0537072302689916}, {23.5, 0.0503515306383226}, {24, 0.0472696665713846}, {24.5, 0.0444342660410422}, {25, 0.0418211757237005}, {25.25, 0}}) annotation(Placement(visible = true, transformation(origin = {-0.899, 0}, extent = {{-24.101, -24.101}, {24.101, 24.101}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-160, -0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98.022, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {155, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102.823, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u, cp_data.u) annotation(Line(visible = true, origin = {-94.91, -0}, points = {{-65.09, -0}, {65.09, 0}}, color = {1, 37, 163}));
  connect(cp_data.y[1], y) annotation(Line(visible = true, origin = {90.306, 0}, points = {{-64.694, -0}, {64.694, 0}}, color = {1, 37, 163}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {0, -25}, lineColor = {255, 255, 255}, fillColor = {149, 23, 41}, fillPattern = FillPattern.Solid, extent = {{-100, -75}, {100, 75}}, radius = 10), Line(visible = true, points = {{-100, 0}, {100, 0}}, color = {255, 255, 255}, thickness = 1), Line(visible = true, origin = {0, -50}, points = {{-100, 0}, {100, 0}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Line(visible = true, origin = {0, -25}, points = {{0, 75}, {0, -75}}, color = {255, 255, 255}, thickness = 1, smooth = Smooth.Bezier), Text(visible = true, origin = {-0, 75.824}, extent = {{-94.23, -21.807}, {94.23, 21.807}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-150, -90}, {150, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end Vestas_V52;
