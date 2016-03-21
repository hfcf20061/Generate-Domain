%% Find out the boxes that should be excluded out and output the box with the left lower points 
% and right upper one.
% the input p is a vector contain a sequence of points where the first and
% last points are both on the boundary.

function [ box, k ] = findbox(p)

%p = [ 5,0;5,6;6,6;6,0 ];
[edge, vedge, hedge, vorient, horient, Nv, Nh] = getedge(p);



% initial assign memeory
box = zeros( Nv + Nh, 4);

% No need to follow the p's counterclock wise order to find the box that
% need to be eliminated, it actually can be parallelized.


%% vertical edges

%sort the vertical edge in the ascending order by its x coordinate
k=0; % record how many boxes

[ temp, ix ] = sort( vedge( :,1 ) );
for i = 1 : Nv
    if ( vorient( ix( i ) ) == 1 ) % upward vedge=(x1,y1,y2)
        j = 1;
        while ( i + j ) <  ( Nv + 1 ),
            ymax = max( vedge( ix( i ), 2 ), vedge( ix( i ), 3 ) );
            ymin = min( vedge( ix( i ), 2 ), vedge( ix( i ), 3 ) );
            
            if  ( ( vedge( ix( i ), 2 ) < ymax  ) && ...
                  ( vedge( ix( i ), 3 ) > ymin  ) )    % has itersection
              
              k = k + 1;
              % (x1,y1,x2,y2)
              box(k,:) = [ vedge( ix( i ), 1 ), vedge( ix( i ), 2 ), ...
                           vedge( ix( i+j ), 1 ), ymax ];
              break;
            else
                j = j + 1;
            end
        end
    else  % for downward edge
        j = 1;
        while ( i - j ) > 0,
            ymax = max( vedge( ix( i ), 2 ), vedge( ix( i ), 3 ) );
            ymin = min( vedge( ix( i ), 2 ), vedge( ix( i ), 3 ) );
            
            if  ( ( vedge( ix( i ), 2 ) > ymin  ) && ...
                  ( vedge( ix( i ), 3 ) < ymax  ) )    % has itersection
              
              k = k + 1;
              % (x1,y1,x2,y2)
              box(k,:) = [ vedge( ix( i-j ), 1 ), ymin, ...
                           vedge( ix( i ), 1 ), vedge( ix( i ), 2 ) ];
              break;
            else
                j = j + 1;
            end
        end
    end
end

clear temp ix i;

%% horizontal edges

[ temp, ix ] = sort( hedge( :,1 ) );
for i = 1 : Nh
    if ( horient( ix( i ) ) == 1 )% leftward hedge=(y1,x1,x2) 
        j = 1;
        while ( i + j ) <  ( Nh + 1 ),
            
            xmax = max( hedge( ix( i ), 2 ), hedge( ix( i ), 3 ) );
            xmin = min( hedge( ix( i ), 2 ), hedge( ix( i ), 3 ) );
            
            if  ( ( hedge( ix( i ), 2 ) > xmin ) && ...% Attention about larger or less
                  ( hedge( ix( i ), 3 ) < xmax ) )    % has itersection
              
              k = k + 1;
              % (x1,y1,x2,y2)
              box(k,:) = [ hedge( ix( i ), 3 ), hedge( ix( i ), 1 ), ...
                                          xmax, hedge( ix( i+j ), 1 ),  ];
              break;
            else
                j = j + 1;
            end
        end
    else % rightward
        j = 1;
        while ( i - j ) > 0,
            
            xmax = max( hedge( ix( i ), 2 ), hedge( ix( i ), 3 ) );
            xmin = min( hedge( ix( i ), 2 ), hedge( ix( i ), 3 ) );
            
            if  ( ( hedge( ix( i ), 2 ) < xmax  ) && ...
                  ( hedge( ix( i ), 3 ) > xmin ) )    % has itersection
              
              k = k + 1;
              % (x1,y1,x2,y2)
              box(k,:) = [                xmin, hedge( ix( i-j ), 1 ), ...
                           hedge( ix( i ), 3 ), hedge( ix( i ), 1 ) ];
              break;
            else
                j = j + 1;
            end
        end
    end
end

clear temp ix i;

% free some memory

%id = ( ( box(:,1) ~= 0 ) | ( box(:,2) ~= 0 ) | ( box(:,3) ~= 0 ) | ( box(:,4) ~= 0 ) );

% if all the coordinate of points are positive  we can optimize by
% id = ( box(:,1) +  box(:,2) +  box(:,3) +  box(:,4) > 0 )
% or 
% id = ( box(:,1) .^ 2 +  box(:,2) .^ 2 +  box(:,3) .^ 2 +  box(:,4) .^ 2 > 0 )

%box = box( id, : );
box = box( 1 : k, : );
end
              
              
                
            
            
             
        
        



