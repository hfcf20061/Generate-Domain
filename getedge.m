%% Find all the edges squentially connect points in p, for the corners situation we give back N+1 edges,
% for the edges' return N edges.
% and distinguish them into vertical and horizontal types with orientation;


function [edge, vedge, hedge, vorient, horient, Nv, Nh] = getedge(p)
% we only input each point once counterclockwise, so for the edge should not forget the edge
% from the last to the first one.

N = size( p, 1 );

% edge is stored as (x1,y1,x2,y2);

% for p1 and PN are both on the same boundary line, 
%namely the line p1-pN should be vertical or horizontal

if ( ( p( 1, 1 ) - p( N, 1 ) ) * ( p( 1, 2 ) - p( N, 2 ) ) == 0 )
    edge = zeros( N, 4 );
    edge( :, 1:2 ) = p;
    edge( :, 3:4 ) = [ p( 2:N, : ); p( 1, : )];

else % four corners situations
    edge = zeros( N + 1, 4 );
    edge( 1:N, 1:2 ) = p;% the Nth one should be modified later
    edge( 1:N, 3:4 ) = [ p( 2:N, : ); p( 1, : )];
    
    % upper right or lower left corner
    if ( ( p( 1, 1 ) - p( N, 1 ) ) * ( p( 1, 2 ) - p( N, 2 ) ) < 0 )   
        edge( N, : )   = [ p( 1, : ), p( 1, 1 ), p( N, 2 ) ];
        edge( N+1, : ) = [ p( 1, 1 ), p( N, 2 ), p( N, : ) ];
    else
        edge( N, : )   = [ p( 1, : ), p( N, 1 ), p( 1, 2 ) ];
        edge( N+1, : ) = [ p( N, 1 ), p( 1, 2 ), p( N, : ) ];
    end
end
            

% figure out the vertical edges since x1=x2
id = ( edge( :,1 ) == edge( :,3 ) );

% vedge=(x1,y1,y2) since x1=x2
vedge = [ edge( id,1:2 ), edge( id,4 ) ]; 

% hedge=(y1,x1,x2) since y1=y2, 
%Attention we assume either vertical or horizontal
hedge = [ edge( ~id,2 ), edge( ~id,1 ), edge( ~id,3 ) ];

Nv = size( vedge, 1 ); %# of vertical edges
Nh = size( hedge, 1 ); %# of horizotal edges

clear id;

vorient = zeros( Nv, 1 );
horient = zeros( Nh, 1 );

id = ( vedge( :,2 ) < vedge( :,3 ) ); % index for upward vertical edge

vorient( id ) = 1;
vorient( ~id ) = -1;

clear id;

id = ( hedge( :,2 ) > hedge( :,3 ) ); % index for leftward horizontal edge
horient( id ) = 1;
horient( ~id ) = -1;

end

