<!DOCTYPE html>
<head>
  <meta http-equiv="content-type" content="text/html; charset={{charset}}">
  <style type="text/css">
    %for line in common.read_lines(CSS):
      {{line.rstrip()}}
    %end
  </style>
</head>

<body>
%# Tree structure
% text = tree.draw() if tree else None
%if text:
<h3>Tree Structure:</h3>
<pre><code>{{text}} </pre></code>
%end

%# Additional files
%if filenames:
  %if text:
    <hr>
  %end
  <h3>Published Documents:</h3>
  <p>
  <ul>
    %for filename in filenames:
      %name = os.path.splitext(filename)[0]
      <li><a href="{{filename}}">{{name}}</a></li>
    %end
  </ul>
  </p>
%end

%# Traceability table
%documents = tree.documents if tree else None
%if documents:
  %if text or filenames:
    <hr>
  %end
  %# table
  <h3>Item Traceability:</h3>
  <p>
  <table>
  %# header
  %for document in documents:  # pylint: disable=not-an-iterable
    <col width="100">
  %end
  <tr>
  %for document in documents:  # pylint: disable=not-an-iterable
    <th height="25" align="center"><a href="{{document.prefix}}.html">{{document.prefix}}</a></th>
  %end
  </tr>
  %# data
  %for index, row in enumerate(tree.get_traceability()):
    <tr {{'class="alt"' if index % 2 else ''}}>
      %for item in row:
        <td height="25" align="center">\\
        %if item is not None: 
          <a href="{{item.document.prefix}}.html#{{item.uid}}">{{item.uid}} {{item.header if item.header else ''}}</a>\\
        %end
        </td>
      %end
    </tr>
  %end
  </table>
  </p>
%end
</body>
</html>