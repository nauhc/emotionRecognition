% A main function that combines upperbodyparts rectagle detector and upperstick
% detector (the later requires the output of the former)
% Author: Chuan Wang vvang@ucdavis.edu

% function [T sticks_imgcoor] = upperstick(base_dir, img_dir, img_fname_format, img_number)

% function [T sticks_imgcoor] = upperstick(base_dir, img_dir, img_fname_format, img_number)
function [bodyparts] = upperstick(base_dir, img_dir, img_fname_format, img_number)

%fullfile(pwd, '../images', sprintf('%04d.jpg', 0))
file = fullfile(base_dir, img_dir, sprintf(img_fname_format, img_number));

if exist(file) 

    load('detenv.mat');
    %get the upperbody detection result
    [ubfdetections] = DetectStillImage(file,'pff_model_upperbody_final.mat',[],det_pars,2);

    if not(isempty(ubfdetections))
        %change the upperbody detection result to input format for stickman
        %detection 
        firstRow = ubfdetections(1, :);
        temp = double(int16(firstRow));
        intbox = temp(1:4);
        bbox = intbox';

        %stickman detection
        startup;
        [T sticks_imgcoor] = PoseEstimStillImage(base_dir, img_dir, img_fname_format, img_number, 'ubf', bbox, fghigh_params, parse_params_Buffy3and4andPascal, [], pm2segms_params, true);
        
        %getting only body parts(remove the head)
        bodyparts = bitor(T.PM.b(:,:,1), T.PM.b(:,:,2))
        bodyparts = bitor(bodyparts, T.PM.b(:,:,3))
        bodyparts = bitor(bodyparts, T.PM.b(:,:,4))
        bodyparts = bitor(bodyparts, T.PM.b(:,:,5))
        

    end

end