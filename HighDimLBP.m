function [ highlbp ] = HighDimLBP( im, pts, gridNumX, gridNumY, patchSize, scale)
%HIGHDIMLBP Summary of this function goes here
%   Detailed explanation goes here    
    [height, width, num_channels] = size(im);
    if num_channels == 3
        im = rgb2gray(im);
    end
    num_scale = length(scale);
    highlbp = [];
    for s = 1 : num_scale
        scaled_pts = int32(pts * scale(s));
        scaled_im = imresize(im, scale(s), 'bilinear');
        [sh, sw] = size(scaled_im);
        scaled_im_pad = uint8(zeros(sh + 40, sw + 40));
        scaled_pts = scaled_pts + 20;
        scaled_im_pad(21 : sh + 20 , 21 : sw + 20) = scaled_im;
%         figure(3);  imshow(scaled_im_pad);     hold on;    plot(scaled_pts(1,:), scaled_pts(2,:), '.'); hold off;
        for p = 1 : size(pts, 2)
            im_patch = scaled_im_pad((scaled_pts(2,p) - gridNumY / 2 * patchSize + 1) : (scaled_pts(2,p) + gridNumY / 2 * patchSize), ...
                (scaled_pts(1,p) - gridNumX / 2 * patchSize + 1) : (scaled_pts(1,p) + gridNumX / 2 * patchSize)) ;
%             figure(2); imshow(im_patch);
            tmp_lbp = IMG2LBP(im_patch, patchSize, patchSize);
            highlbp = [highlbp; tmp_lbp];
        end
    end
end

