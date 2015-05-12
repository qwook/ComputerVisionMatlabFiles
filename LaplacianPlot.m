pkg load image

X = fspecial('log')
y = (1:1:rows(X))
x = (1:1:columns(X))
z = X(x,y)

#[X,Y,Z] = peaks(25);

figure
surf(x,y,z);

#imshow(X);