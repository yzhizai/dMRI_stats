function powerplot
%%
close all
myval = abs(cat(1, zeros(1, 1000), Fval));
% x =[3/2, 7/3, 4/1, 9];
x = 0:15:180;
figure
hold on
for aa = 1:size(myval, 2)
    plot(x, myval(:, aa), 'g-');
end
plot(x, mean(myval, 2), 'b-o', 'LineWidth', 1)
xlabel('partial volume');
ylabel('F value');

watpower = sum(myval > 19.5, 2)/1000;
figure
plot(x, watpower(:), 'b-o');
hold on
% plot(x, ones(1, 6)*0.8, '--r')
xlabel('partial volume')
ylabel('Power');
ylim([-0.2, 1.2]);
hold off
%%
x = 15:15:90;
watPower = [0, ones(1, 5)];
figure;
plot(x, watPower, 'b-o');
hold on
plot(x, ones(1, 6)*0.8, '--r')
ylim([-0.2, 1.2]);
xlabel('Angle')
ylabel('Power');
