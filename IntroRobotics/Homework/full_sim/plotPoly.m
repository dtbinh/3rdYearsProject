function h = plotPoly(p,varargin)
 p = [p p(:,1)];
 if isempty(varargin)
 h = plot(p(1,:),p(2,:));
 else
h = plot(p(1,:),p(2,:),varargin{1});
 end
end