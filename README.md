# TSP-matlab-pcode
# (multiple) Traveling Salesmen Problem

  TSP: finds a solution of the Traveling Salesmen Problem based
       on the so-called 3-neighbourhood method [local optimal]
       or Miller-Tucker-Zemlin (MTZ) model [single- or multiple-TSP]
       or Gavish-Graves (GG) model [single- or multiple-TSP]
       (via the powerful "intlinprog" function of MATLAB).
 
 
  Input:
 
  D = distance matrix (full or sparse version), with D(i,j) denoting the
      direct distance between i-th and j-th sites in the original graph.
 
  s = starting site, taken in the paired formation of 's' and its value
      [selected randomly by default].
 
  v = a vector of sites to be travelled, taking the paired formation
      of 'v' and its value [all other than s by default].
 
  k = maximum iteration number, used to present search ending prematurely
      with the paired formation of 'k' and its value [1000 by default].
 
  m = number of salesmen, with the paired formation of 'm' and its value
      [taken as 1 by default].
 
  L = minimal number of sites that one salesman travels, with the paired
      formation of 'L' and its value[taking 1 by default].
      NOTE: here is a bug, so 'L' is currently not recommeded to use!!!
 
  U = maximal number of sites that one salesman travels, with the paired
      formation of 'U' and its value [taking n-m by default].
 
  a = algorithm used, with the paired formation of 'a' and its value
      [taken as '3n' by default (the other two are 'MTZ' and 'GG')].
 
  V = velocity that every salesman travels (the same), with the paired
      formation of 'V' and its value [taking 1 by default].
 
  t = a time vector denoting how long the salesman stays, with the paired
      formation of 't' and its value [taking zeros(1,n) by default].
 
 
  Output:
 
  p = (nearly) optimal path(s) in the original graph:
      - in the case of the 'GG' algorithm with m > 1, p is a cell
        of m paths, each of which is for one saleman, in the formation
        of a vector of sites, starting from and ending at s.
      - other cases: a vector of sites, starting from and ending at s.
 
  d = total distance travelled associated with p:
      - in the case of the 'GG' algorithm with m > 1, d is a vector
        of m distances, each of which is for one saleman.
      - other cases: a numerical value.
 
  q = (nearly) optimal path(s) in the complete graph, similar to p.
 
  K = stay-or-not logical vector(s), similar to p.
 
 
  For the 3-neighbourhood method:
  see "朱道元，数学建模精品案例，南京：东南大学出版社，1999".
 
  For the MTZ model:
  see "Miller, C.E., Tucker, A.W., Zemlin, R.A. (1960).
       Integer programming formulation of traveling salesman
       problems. Journal of the ACM 7(4): 326-329"
  and "Gavish B. (1976). A note on the formulation of the msalesman
       traveling salesman problem. Management Science 22(6): 704-705".
 
 
  For the GG model:
  see "Gavish, B., Graves, S.C. (1978).
       The travelling salesman problem and related problems".
  
 
  URL: https://blog.csdn.net/Zhang_0702_China/article/details/106983492
 
 
  An important note:
      Maybe it is only a bug, but I really indeed find that
      to use 'GG' is faster than to use 'MTZ' when m = 1, while
      'MTZ' can get a better solution than 'GG' m > 1, if
      both algorithms ignore the lower and upper bounds, L and U.
 
 
  Written by Xu-Qing Liu (liuxuqing688@163.com) // July 26, 2020
 
 
  Example:
  
  load AdjMat A
  
  [p,d,q,K] = TSP(A,'s',50,'a','3n')
  
  [p,d,q,K] = TSP(A,'s',50,'a','MTZ')
  
  [p,d,q,K] = TSP(A,'s',50,'a','MTZ','m',3)
  
  [p,d,q,K] = TSP(A,'s',50,'a','GG')
  
  [p,d,q,K] = TSP(A,'s',50,'a','GG', 'm',3)
  
  [p,d,q,K] = TSP(A,'s',50,'a','GG', 'm',3,'U',20)
 
 
  See also graphshortestpath and intlinprog.
  
