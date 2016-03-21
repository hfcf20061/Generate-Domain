function [ points ] = main()

%% Input corner points 
% we only input all points once, so for the edge should not forget the edge
% from the last to the first one.
% If all the input coordinates are positive we can switch the last id in
% findbox.m to better way.
% points(1,:) is the outer box and the rest lines are boxes that need to be
% excluded.




% p = [ 0, 1; 
%       3, 1; 
%       3, 0;
%       5, 0;
%       5, 6;
%       6, 6;
%       6, 0;
%      14, 0;
%      14, 2;
%      13, 2;
%      13, 3;
%      14, 3;
%      14, 8;
%      10, 8;
%      10,10;
%       2,10;
%       2, 4;
%       0, 4;];

% text4_input.txt file 
% p = [ 1, 0;
%       5, 0;
%       5, 7.5;
%       6, 7.5;
%       6, 0;
%       12, 0;
%       12, 2;
%       10.5, 2;
%       10.5, 3.5;
%       12, 3.5;
%       12, 9;
%       9, 9;
%       9, 11;
%       0, 11;
%       0, 8;
%       -2, 8;
%       -2, 1;
%       1, 1; ];
  
p = [ 1, 0;
      5, 0;
      5, 7.5;
      7, 7.5;
      7, 6;
      6, 6;
      6, 0;
      12, 0;
      12, 2;
      10.5, 2;
      10.5, 3.5;
      12, 3.5;
      12, 9;
      9, 9;
      9, 11;
      0, 11;
      0, 8;
      -2, 8;
      -2, 1;
      1, 1; ];
  
  
plot( p( :, 1 ), p( :, 2 ) );

%% test point
% p = [ 0, 0;
%        4, 0;
%        4, 4;
%        2, 4;
%        2, 6;
%        0, 6; ];
% plot( p( :, 1 ), p( :, 2 ) );
% 
% [edge, vedge, hedge, vorient, horient, Nv, Nh] = getedge(p);
% edge
% vedge
% hedge
% vorient
% horient
% Nv
% Nh
%% prepare memory

N = size( p, 1 );
points = zeros( N, 4 );

%% PB coordinate
%[xmin,ymin,xmax,ymax]
xmin = min( p( :,1 ) );
ymin = min( p( :,2 ) );
xmax = max( p( :,1 ) );
ymax = max( p( :,2 ) );


points( 1, : ) = [ xmin, ymin, xmax, ymax ];
num = 1; % record how many boxes in all
p = reorder( p, points, N );
% starting from the bdd point



%% searching boxes to exclude

start = 1; % start is the starting point on the bdd for the block
i = 1; % to mark how many points has searching through & avoid dead loop
while i < N + 1; % at least need to two inner edges to form a block
    
    tail = check( start + 1, N );
    i = i + 1; 
    
    if ( ( p( tail, 1 ) - xmin ) * ( p( tail, 1 ) - xmax ) * ...
         ( p( tail, 2 ) - ymin ) * ( p( tail, 2 ) - ymax ) == 0 )  % on the boundary
     
     start = tail;
   
    else
        
        tail = check( tail + 1, N );
        i = i + 1;
        
        while ( ( p( tail, 1 ) - xmin ) * ( p( tail, 1 ) - xmax ) * ...
                ( p( tail, 2 ) - ymin ) * ( p( tail, 2 ) - ymax ) ~= 0 ), 
            
          tail = check( tail + 1, N );
          i = i + 1;
        end
        
        if tail < start
            [ box, sizebox ] = findbox( [ p( start : N, : ); p( 1 : tail, : ) ] );
        else
            [ box, sizebox ] = findbox( p( start : tail, : ) );
        end
        
        points( ( num + 1 ) : ( num + sizebox ), : ) = box;
        num = num + sizebox;
        clear box sizebox;
        
        start = tail;  
    end
end

points = points( 1 : num, : );

%display( points );
        
   


end

%% future work
% To make the code stable we had better check all the edges are either
% vertical or horizontal














