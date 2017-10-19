function new_order = reArrange_diffusion_gradient(bvec)

neg_indx = bvec < 0;
% neg_indx(1:2, :) = 0;
neg_indx_z = repmat(neg_indx(3, :), 3, 1);
neg_indx_z = neg_indx_z*(-2) + 1;
bvec = bvec.*neg_indx_z;

figure
subplot(1, 2, 1)
coor_xyz = zeros(3, 64);
coor_dir = bvec(:, 2:end);
quiver3(coor_xyz(1, :), coor_xyz(2, :), coor_xyz(3, :), coor_dir(1, :), ...
    coor_dir(2, :), coor_dir(3, :), 0);
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');


subplot(1, 2, 2)
quiver3(coor_xyz(1, :), coor_xyz(2, :), coor_xyz(3, :), coor_dir(1, :), ...
    coor_dir(2, :), coor_dir(3, :), 0);
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
hold on 
azim = repmat(linspace(0, 2*pi, 100), 1, 20);
elev = linspace(pi/2, 0, 2000);

[xx, yy, zz] = sph2cart(azim, elev, 1);

plot3(xx(:), yy(:), zz(:));

hold off

[azim, elev, ~] = cart2sph(bvec(1, 2:end), bvec(2, 2:end), bvec(3, 2:end));
sph_array = [azim', (pi/2 - elev)'];
[~, new_order] = sortrows(sph_array, [2, 1]);

% sph_table = array2table([azim', elev']);
% 
% sph_table.Properties.VariableNames = {'azim', 'elev'};
