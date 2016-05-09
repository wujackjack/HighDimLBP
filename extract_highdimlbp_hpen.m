clear;
im_dir = dir('G:\LFW_HPEN\LFW_Norm_Demo\*.jpg');
filepath = 'G:\LFW_HPEN\LFW_Norm_Demo\';
selIdx = [18 22 23 27 37 69 40 43 70 46 31 32 36 49 52 55];
scale = [300 212 150 106 75] / 250;
fp = fopen('lfw_13233.txt', 'r');
highlbp_lfw = uint8(zeros(75520, 13233));
for i = 1 : length(im_dir)
%     im = imread([filepath im_dir(i).name]);
%     load([filepath im_dir(i).name(1:end-4) '.mat']);
    if mod(i, 10) == 0
        fprintf('i = %d\n', i);
    end
    str = fgetl(fp);
    idx = find(str == '/');
    im_str = [str(idx + 1 : end - 4) '_N.jpg'];
    im = imread([filepath im_str]);
    load([filepath im_str(1 : end - 4) '.mat']);
    pts = [pts (pts(:,37) + pts(:,40)) / 2 (pts(:,43) + pts(:,46)) / 2];
    pts = pts(:, selIdx);
    figure(1);  imshow(im);     hold on;    plot(pts(1,:), pts(2,:), '.');
    highlbp = HighDimLBP(im, pts, 4, 4, 10, scale);
    highlbp_lfw(:, i) = uint8(highlbp);
end
highlbp_lfw = uint8(highlbp_lfw');
% save('highlbp_lfw_v2', 'highlbp_lfw', '-v7.3');
fclose(fp);