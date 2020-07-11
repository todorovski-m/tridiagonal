clc; clear;
res = tridiag_compare();
m = size(res,2);
name = cell(m,1);
for i = 1:m
    name{i} = res(i).name;
end

n = 10;
factor = 1e6;
t = zeros(m, n);
for j = 1:n
    res = tridiag_compare(@() ex_n(factor*j));
    for i = 1:m
        t(i,j) = res(i).t;
    end
end

fid = fopen('times.txt', 'w');
fprintf(fid,'%23s', 'n -- >');
fprintf(fid,'%10i',(1:n)*factor);
fprintf(fid, '\n');
for i = 1:m
    fprintf(fid,'%-23s', name{i});
    fprintf(fid,'%10.2e',t(i,:));
    fprintf(fid, '\n');
end
fclose(fid);