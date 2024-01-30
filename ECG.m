clear
clc
close all

t = 1:3600 ;
load('100m.mat') ;
half = val(t) ;
detrend = detrend(half) ;
[~, pks] = findpeaks(detrend,'MinPeakHeight',100) ;
% size(pks)

plot(t,detrend,t(pks),detrend(pks),'r*')
legend('Original', 'Peak', 'Location', 'northwest') ;
xlabel('Time (sec)') ;

count = 0 ;
gap = [] ;
head = 0 ;
tail = 0 ;
for i = 1:length(pks)
    % disp("R peak: ")
    % disp(pks(i))
    count = count + pks(1) ;

    if i ~= length(pks)
      if pks(i+1) - pks(i) > max(gap)
          head = pks(i) ;
          tail = pks(i+1) ;
      end
      gap(end+1) = pks(i+1) - pks(i) ;
    end
end

count = count / length(pks) ;
disp("R peak")
disp(pks)
disp("Waveform gap")
disp(gap)
disp("Average waveform: ")
disp(count)  % 76


x = 1:max(gap) ;
y = head:tail-1 ;
y = val(y) ;

p = polyfit(x, y, 25) ;
% y1 = x.^5*p(1) + x.^4*p(2) + x.^3*p(3) + x.^2*p(4) + x.*p(5) + p(6) ;
y1 = polyval(p, x) ;

figure ;
scatter(x, y, ".") ;
hold on ;
plot(x, y1)
xlabel("x");
ylabel("y");
legend("data point", "fit line")



















