  clear, clc, close all, format compact, format shortg
  
% load data
  load xy x y
  load AdjMat A
  
% darw the graph
  G = graph(A);
  E = G.Edges.EndNodes;
  figure('position',[20 100 900 550],'Color',[1 1 1])
  M = plot(G);
  
% set the coordinates
  M.XData = x;
  M.YData = y;
  axis([min(x) max(x) min(y) max(y)], 'ij', 'off')
  
% modify the properties of nodes
  M.NodeLabel(36:53) = cellstr(char((65:82)'));
  M.Marker = cellstr(char(ones(53,1)*'o'));
  M.Marker([36:49 51:53]) = cellstr(char(ones(17,1)*'^'));
  M.Marker(50) = cellstr(char('p'));
  M.MarkerSize = ones(1,53)*5;
  M.MarkerSize([36:49 51:53]) = 6;
  M.MarkerSize(50) = 9;
  M.NodeColor = zeros(53,3);
  M.NodeColor([36:49 51:53],:) = ones(17,1)*[0 0 1];
  M.NodeColor(50,:) = [1 0 0];
  
% modify the properties of edges
  M.EdgeLabel = G.Edges.Weight;
  M.LineWidth = 1.5; %ones(size(E,1),1)*1.5;
  M.LineStyle = '-'; %cellstr(char(ones(size(E,1),1)*'-'));
  M.EdgeAlpha = 1;
  %M.EdgeColor = [0.5 0.5 0.5];
  M.EdgeColor = ones(size(E,1),1)*[0.5 0.5 0.5];
  
% search a solution via the "3-neighborhood" or "mixed integer LP"
  s = rng(450896); [p,d,q] = TSP(A,'s',50,'a','3n'), rng(s)
  %[p,d,q] = TSP(A,'s',50,'a','MTZ')
  %[p,d,q] = TSP(A,'s',50,'a','MTZ','m',3)
  %[p,d,q] = TSP(A,'s',50,'a','GG')
  %[p,d,q] = TSP(A,'s',50,'a','GG', 'm',3)
  %[p,d,q] = TSP(A,'s',50,'a','GG', 'm',3,'U',20)
  
% show the graphical results
  n_E = size(E,1);
  M.EdgeColor = ones(n_E,1)*[0.75 0.75 0.75];
  M.LineWidth = 1.5*ones(n_E,1);
  E_used = zeros(0,2);
  for i = 1:length(p)-1
      E_i = sort(p(i:i+1));
      [~,j] = ismember(E_i,E,'rows');
      %---
      if (ismember(E_i,E_used,'rows'))
          [~,j] = ismember(E_i,E,'rows','legacy');
      end
      E_used = [E_used; E_i];
      %---
      M.EdgeColor(j,:) = [0.9 0.3 0];
      M.LineWidth(j) = 2.5;
      pause(0.5)
  end
  
% save the figure
  print(gcf,'-dtiff', 'BestPath.tif', '-r300')
  
% type the route on the Command Window
  q = cell(1,length(p));
  for i = 1:length(p)
      if (p(i) <= 35)
          q{i} = num2str(p(i));
      else
          q{i} = char(p(i)+29);
      end
  end
  fprintf('Path: ')
  for i = 1:length(p)-1
      fprintf('%s-',q{i})
  end
  fprintf('%s\n',q{end})
  