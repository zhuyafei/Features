function [h,s,v] = rgb2hsv(r,g,b)
switch nargin
  case 1,
     if isa(r, 'uint8'), 
        r = double(r) / 255; 
     elseif isa(r, 'uint16')
        r = double(r) / 65535;
     end
  case 3,
     if isa(r, 'uint8'), 
        r = double(r) / 255; 
     elseif isa(r, 'uint16')
        r = double(r) / 65535;
     end
     
     if isa(g, 'uint8'), 
        g = double(g) / 255; 
     elseif isa(g, 'uint16')
        g = double(g) / 65535;
     end
     
     if isa(b, 'uint8'), 
        b = double(b) / 255; 
     elseif isa(b, 'uint16')
        b = double(b) / 65535;
     end
     
  otherwise,
      error(message('MATLAB:rgb2hsv:WrongInputNum'));
end
  
threeD = (ndims(r)==3); % Determine if input includes a 3-D array

if threeD,
  g = r(:,:,2); b = r(:,:,3); r = r(:,:,1);
  siz = size(r);
  r = r(:); g = g(:); b = b(:);
elseif nargin==1,
  g = r(:,2); b = r(:,3); r = r(:,1);
  siz = size(r);
else
  if ~isequal(size(r),size(g),size(b)), 
    error(message('MATLAB:rgb2hsv:InputSizeMismatch'));
  end
  siz = size(r);
  r = r(:); g = g(:); b = b(:);
end

v = max(max(r,g),b);
h = zeros(size(v));
s = (v - min(min(r,g),b));

z = ~s;
s = s + z;
k = find(r == v);
h(k) = (g(k) - b(k))./s(k);
k = find(g == v);
h(k) = 2 + (b(k) - r(k))./s(k);
k = find(b == v);
h(k) = 4 + (r(k) - g(k))./s(k);
h = h/6;
k = find(h < 0);
h(k) = h(k) + 1;
h=(~z).*h;

k = find(v);
s(k) = (~z(k)).*s(k)./v(k);
s(~v) = 0;

if nargout<=1,
  if (threeD || nargin==3),
    h = reshape(h,siz);
    s = reshape(s,siz);
    v = reshape(v,siz);
    h=cat(3,h,s,v);
  else
    h=[h s v];
  end
else
  h = reshape(h,siz);
  s = reshape(s,siz);
  v = reshape(v,siz);
end