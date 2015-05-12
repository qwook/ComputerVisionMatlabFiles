pkg load image

image = rgb2gray(im2double( imread('images/09.jpg') ));

sig = 2
% gaussian
h = fspecial('gaussian', sig*3*2+1, sig);
% laplac
h2 = fspecial('laplacian', 1);
h3 = conv2(h, h2);

s = imfilter(image, h3);

x = ones(size(s));

threshold = .75*mean2(abs(s));

for i = 2:rows(x)-1
	for j = 2:columns(x)-2
		slope = abs(s(i-1, j) - s(i+1, j));
		if slope > threshold
			if (s(i-1, j) < 0 && s(i+1, j) > 0) || (s(i-1, j) > 0 && s(i+1, j) < 0)
				x(rows(x)-i, j) = 0;
			elseif (s(i, j-1) < 0 && s(i, j+1) > 0) || (s(i, j-1) > 0 && s(i, j+1) < 0)
				x(rows(x)-i, j) = 0;
			elseif (s(i+1, j+1) < 0 && s(i-1, j-1) > 0) || (s(i+1, j+1) > 0 && s(i-1, j-1) < 0)
				x(rows(x)-i, j) = 0;
			elseif (s(i+1, j-1) < 0 && s(i-1, j+1) > 0) || (s(i+1, j-1) > 0 && s(i-1, j+1) < 0)
				x(rows(x)-i, j) = 0;
			end
		end
	end
end

imshow(x);