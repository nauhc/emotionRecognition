function upperbody()

% for n = 0000:0129
%     upperstick(pwd, '../images', '%04d.jpg', n);
% end

% for n = 1000:1094
%     upperstick(pwd, '../images', '%04d.jpg', n);
% end

% for n = 2000:2110
%     upperstick(pwd, '../images', '%04d.jpg', n);
% end

% for n = 3000:3118
%     upperstick(pwd, '../images', '%04d.jpg', n);
% end


% for n = 4000:4102
%     upperstick(pwd, '../images', '%04d.jpg', n);
% end


    for n = 2083:4102
        bodybox = cascadeUpperstick(pwd, '../images', '%04d.jpg', n);
    end

% cascadeUpperstick(pwd, '../images', '%04d.jpg', 3);

end