image = imread('3.jpg');
image_rgb = im2double( image );
RGB_bins = [16 16 16];
R = image_rgb(:,:,1);
G = image_rgb(:,:,2);
B = image_rgb(:,:,3);
rr = min( floor(R*RGB_bins(1)) + 1, RGB_bins(1) );
gg = min( floor(G*RGB_bins(2)) + 1, RGB_bins(2) );
bb = min( floor(B*RGB_bins(3)) + 1, RGB_bins(3) );
Q_rgb = (rr-1) * RGB_bins(2) * RGB_bins(3) + ...
    (gg-1) * RGB_bins(3) + ...
    bb + 1;