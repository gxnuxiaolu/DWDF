function mag = gaborlv(im)
wavelength = 8;
orientation = 0;
[mag1,~] = imgaborfilt(im,wavelength,orientation);
wavelength = 8;
orientation = 45;
[mag2,~] = imgaborfilt(im,wavelength,orientation);
wavelength = 8;
orientation = 90;
[mag3,~] = imgaborfilt(im,wavelength,orientation);
wavelength = 8;
orientation = 135;
[mag4,~] = imgaborfilt(im,wavelength,orientation);
mag = (mag1+mag2+mag3+mag4)./4;
end

