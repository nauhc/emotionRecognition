
%CASCADEUPPERSTICK Summary of this function goes here
%   Detailed explanation goes here

% function [T sticks_imgcoor] = cascadeUpperstick(base_dir, img_dir, img_fname_format, img_number)
function [bodybox] = upperstick(base_dir, img_dir, img_fname_format, img_number)

%fullfile(pwd, '../images', sprintf('%04d.jpg', 0))
file = fullfile(base_dir, img_dir, sprintf(img_fname_format, img_number))

if exist(file) 

    upperbodyDetector = vision.CascadeObjectDetector('UpperBody');
    I = imread(file);
    box = step(upperbodyDetector, I);
    [m, n] = size(box);

    if m > 0
        %change the upperbody detection result to input format for stickman
        %detection 
        for x = 1:m

            [ubfdetections] = box(m, :);
            bbox = ubfdetections';

            %stickman detection
            if not(isempty(ubfdetections))
                startup;
                [T sticks_imgcoor] = PoseEstimStillImage(base_dir, img_dir, img_fname_format, img_number, 'ubf', bbox, fghigh_params, parse_params_Buffy3and4andPascal, [], pm2segms_params, true);

                %getting only body parts(remove the head)
                bodyparts = bitor(T.PM.b(:,:,1), T.PM.b(:,:,2));
                bodyparts = bitor(bodyparts, T.PM.b(:,:,3));
                bodyparts = bitor(bodyparts, T.PM.b(:,:,4));
                bodyparts = bitor(bodyparts, T.PM.b(:,:,5));
                
                %bounding box on bodyparts
                bw = im2bw(bodyparts, 0.1);
                Isize = size(I);
                bw = imresize(bw, [Isize(1) Isize(2)]);
                bodybox = regionprops(bw, 'BoundingBox');
                Iroi = imcrop(I, bodybox.BoundingBox);
                %imshow(I), figure, imshow(imresize(bodyparts, [Isize(1) Isize(2)]))
                imshow(I), figure, imshow(Iroi)
                
                
            end
        end
    end

end

end

