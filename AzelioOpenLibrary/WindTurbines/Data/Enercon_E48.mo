within AzelioOpenLibrary.WindTurbines.Data;

block Enercon_E48 "Table look-up in one dimension (matrix/file) with one input and n outputs"
  extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
  parameter Boolean tableOnFile = false "= true, if table is defined on file or in function usertab" annotation(Dialog(group = "Table data definition"));
  parameter Real table[:, :] = {{0.0, 0.0}, {1.0, 0.0}, {2.0, 0.0}, {2.99999, 0.0}, {3.0, 0.17}, {4.0, 0.35}, {5.0, 0.43}, {6.0, 0.46}, {7.0, 0.47}, {8.0, 0.48}, {9.0, 0.5}, {10.0, 0.5}, {11.0, 0.45}, {12.0, 0.39}, {13.0, 0.32}, {14.0, 0.27}, {15.0, 0.22}, {16.0, 0.18}, {17.0, 0.15}, {18.0, 0.13}, {19.0, 0.11}, {20.0, 0.09}, {21.0, 0.08}, {22.0, 0.07000000000000001}, {23.0, 0.07000000000000001}, {24.0, 0.05}, {25.0, 0.05}, {31.00, 0.0}} "Table matrix (grid = first column; e.g., table=[0,2])" annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
  parameter String tableName = "NoName" "Table name on file or in function usertab (see docu)" annotation(Dialog(group = "Table data definition", enable = tableOnFile));
  parameter String fileName = "NoName" "File where matrix is stored" annotation(Dialog(group = "Table data definition", enable = tableOnFile, loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat)", caption = "Open file in which table is present")));
  parameter Boolean verboseRead = true "= true, if info message that file is loading is to be printed" annotation(Dialog(group = "Table data definition", enable = tableOnFile));
  parameter Integer columns[:] = 2:size(table, 2) "Columns of table to be interpolated" annotation(Dialog(group = "Table data interpretation"));
  parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of table interpolation" annotation(Dialog(group = "Table data interpretation"));
protected
  Modelica.Blocks.Types.ExternalCombiTable1D tableID = Modelica.Blocks.Types.ExternalCombiTable1D(if tableOnFile then tableName else "NoName", if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", table, columns, smoothness) "External table object";
  parameter Real tableOnFileRead(fixed = false) "= 1, if table was successfully read from file";

  function readTableData "Read table data from ASCII text or MATLAB MAT-file"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Boolean forceRead = false "= true: Force reading of table data; = false: Only read, if not yet read.";
    input Boolean verboseRead "= true: Print info message; = false: No info message";
    output Real readSuccess "Table read success";
  
    external "C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation(__ModelicaAssociation_Impure = true);
  end readTableData;

  function getTableValue "Interpolate 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable "Dummy input to ensure correct sorting of function calls";
    output Real y;
  
    external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation(derivative(noDerivative = tableAvailable) = getDerTableValue);
  end getTableValue;

  function getTableValueNoDer "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable "Dummy input to ensure correct sorting of function calls";
    output Real y;
  
    external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getTableValueNoDer;

  function getDerTableValue "Derivative of interpolated 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable "Dummy input to ensure correct sorting of function calls";
    input Real der_u;
    output Real der_y;
  
    external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getDerTableValue;
initial algorithm
  if tableOnFile then
    tableOnFileRead := readTableData(tableID, false, verboseRead);
  else
    tableOnFileRead := 1.;
  end if;
equation
  if tableOnFile then
    assert(tableName <> "NoName", "tableOnFile = true and no table name given");
  else
    assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
  end if;
  if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
    for i in 1:nout loop
      y[i] = getTableValueNoDer(tableID, i, u, tableOnFileRead);
    end for;
  else
    for i in 1:nout loop
      y[i] = getTableValue(tableID, i, u, tableOnFileRead);
    end for;
  end if;
  annotation(Documentation(info = "<html>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>columns</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that one input
and 2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one row</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
     u &gt; table[size(table,1),1] or u &lt; table[1,1], the corresponding
     value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.
      See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
      documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{0, 40}, {0, -40}}), Rectangle(visible = true, fillColor = {255, 215, 136}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {-30, 40}}), Rectangle(visible = true, fillColor = {255, 215, 136}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, 0}, {-30, 20}}), Rectangle(visible = true, fillColor = {255, 215, 136}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, -20}, {-30, 0}}), Rectangle(visible = true, fillColor = {255, 215, 136}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, -40}, {-30, -20}}), Line(visible = true, points = {{-60, 40}, {-60, -40}, {60, -40}, {60, 40}, {30, 40}, {30, -40}, {-30, -40}, {-30, 40}, {-60, 40}, {-60, 20}, {60, 20}, {60, 0}, {-60, 0}, {-60, -20}, {60, -20}, {60, -40}, {-60, -40}, {-60, 40}, {60, 40}, {60, -40}}, color = {64, 64, 64})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 36, 164}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, extent = {{-60, -60}, {60, 60}}), Line(visible = true, points = {{-100, 0}, {-60, 0}}, color = {0, 36, 164}), Line(visible = true, points = {{60, 0}, {100, 0}}, color = {0, 36, 164}), Text(visible = true, textColor = {64, 64, 64}, extent = {{-100, 64}, {100, 100}}, textString = "1 dimensional linear table interpolation"), Line(visible = true, points = {{-54, 40}, {-54, -40}, {54, -40}, {54, 40}, {28, 40}, {28, -40}, {-28, -40}, {-28, 40}, {-54, 40}, {-54, 20}, {54, 20}, {54, 0}, {-54, 0}, {-54, -20}, {54, -20}, {54, -40}, {-54, -40}, {-54, 40}, {54, 40}, {54, -40}}, color = {64, 64, 64}), Line(visible = true, points = {{0, 40}, {0, -40}}, color = {64, 64, 64}), Rectangle(visible = true, lineColor = {64, 64, 64}, fillColor = {254, 204, 108}, fillPattern = FillPattern.Solid, extent = {{-54, 20}, {-28, 40}}), Rectangle(visible = true, lineColor = {64, 64, 64}, fillColor = {254, 204, 108}, fillPattern = FillPattern.Solid, extent = {{-54, 0}, {-28, 20}}), Rectangle(visible = true, lineColor = {64, 64, 64}, fillColor = {254, 204, 108}, fillPattern = FillPattern.Solid, extent = {{-54, -20}, {-28, 0}}), Rectangle(visible = true, lineColor = {64, 64, 64}, fillColor = {254, 204, 108}, fillPattern = FillPattern.Solid, extent = {{-54, -40}, {-28, -20}}), Text(visible = true, textColor = {64, 64, 64}, extent = {{-52, 44}, {-34, 56}}, textString = "u"), Text(visible = true, textColor = {64, 64, 64}, extent = {{-22, 42}, {2, 54}}, textString = "y[1]"), Text(visible = true, textColor = {64, 64, 64}, extent = {{4, 42}, {28, 54}}, textString = "y[2]"), Text(visible = true, textColor = {64, 64, 64}, extent = {{0, -54}, {32, -40}}, textString = "columns")}));
end Enercon_E48;
