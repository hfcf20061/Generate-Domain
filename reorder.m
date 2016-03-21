%% Using this function to reorder p such that p1 is on the boundary to be used as starting point
% points = [ xmin,ymin,xmax,ymax ]
function [ pnew ] = reorder( p, points, N )

i = 1;

while ( ( p( i, 1 ) - points( 1 ) ) * ( p( i, 1 ) - points( 3 ) ) * ...
         ( p( i, 2 ) - points( 2 ) ) * ( p( i, 2 ) - points( 4 ) ) ~= 0 ),  % not on the boundary
     i = i + 1;
end


pnew = [ p( i : N, : ); p( 1 : ( i - 1 ), : ) ];

end