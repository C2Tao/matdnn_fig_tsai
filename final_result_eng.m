SCORE_TYPE = {'NED', 'match', 'group', 'type', 'token', 'boundary', 'coverage'};
SCORE_NAME = {'NED', 'matching', 'grouping', 'type', 'token', 'boundary', 'coverage'};
SPEAKER_TYPE = {'total', 'within'};
PRF = {'precision', 'recall', 'fscore'};

figure;

% Ū eng scores
lan = 'eng';
load([lan '/mfc.mat']);
mfc = stat;
load([lan '/merge.mat']);
merge = stat;
load([lan '/mrg2.mat']);
mrg2 = stat;
load([lan '/mbf.mat']);
mbf = stat;
clear stat;

load([lan '/baseline.mat']);

% �e�� (eng)
for i=1:6
    % ��ݭn�����ƨӬ� (total speaker, F-score)
    score_type = SCORE_TYPE{i};
    speaker_type = SPEAKER_TYPE{1};
    prf = PRF{3};

    tmp = [mfc.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = tmp;

    tmp = [merge.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; tmp];

    tmp = [mrg2.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; tmp];

    tmp = [mbf.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; tmp];

    data = reshape(data', 4, [])';
    bsln = baseline.(score_type).(prf);
    
    
    xmin = 0.4;
    xmax = 12.6;
    
    % �l�ϼ��D
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.25 + mod(6-i, 3)*0.3, 0.45, 0.05]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmin], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmax, xmax], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [0, 0], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [1, 1], 'Color', 'black', 'LineWidth', 1);
    text(6.5, 0.5, SCORE_NAME{i}, 'FontSize', 15, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    text(0.5, 0.5, ['(JHU: ' num2str(bsln) ')'], 'FontSize', 13, 'FontName', 'Times New Roman');

    % �[�W���W�� (a)
    if i==1
        text (xmin-0.7, 1, '(a)', 'FontSize', 16, 'FontName', 'Times New Roman')
    end        
    
    % �l�ϤU��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.01 + mod(6-i, 3)*0.3, 0.45, 0.04]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmin], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmax, xmax], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [0, 0], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [1, 1], 'Color', 'black', 'LineWidth', 1);
    for k=1:3
        line([3*k+0.5, 3*k+0.5], [0 1], 'Color', 'black', 'LineWidth', 3);
    end
    labels = {'(4)TOK-1st, MR-0', '(5)TOK-1st, MR-1', '(6)TOK-1st, MR-2', '(8)TOK-2nd, MR-1'};
    for k=1:4
        text(3*k-1, 0.5, labels{k}, 'FontSize', 12, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    end
    
    
    % �l��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.05 + mod(6-i, 3)*0.3, 0.45, 0.2]);
    
    % ��e�@��������
    b = bar(1:3, data(1:3, :));
    if i < 4
        set(b, 'FaceColor', 'white');
    else
        set(b, 'FaceColor', 'c');
    end
    
    % �� (A) �����ڪ����t�Ϧ�����
    set(b(1), 'EdgeColor', 'r');
    
    hold on;
    
    % �e�ѤU������
    b = bar([1 2 4:12], data([1 2 4:12], :));
    if i < 4
        set(b, 'FaceColor', 'white');
    else
        set(b, 'FaceColor', 'c');
    end
    
    % �]�w x, y �b�e�Ͻd��
    m = min(data(:));
    M = max(data(:));
    d = (M-m)/10;
    ymin = max(0, m-d);
    ymax = min(1, M+d);
    ymax = ymax + (ymax-ymin)*0.35;
    axis([xmin xmax ymin ymax]);
    
    % �M�� x �b����
    set(gca, 'XTick', []);
    
    % �C�ժ��϶������j�u
    for k=1:11
        line([k+0.5, k+0.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 2);
    end
    for k=1:3
        line([3*k+0.5, 3*k+0.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 3);
    end
    
    % �l�ϤW�U�[�u, �M���D�B�U�аϹj�}��
    line([xmin, xmax], [ymax, ymax], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [ymin, ymin], 'Color', 'black', 'LineWidth', 1);
    %line([xmin, xmax], [1 1]*(ymax - (ymax-ymin)*0.17), 'Color', 'black', 'LineWidth', 1);
     
    % �[�W�C�ժ��Ϫ��W�� (m=3,5,7)
    for k=1:4
        for l=1:3
            text((k-1)*3 + l, ymax - (ymax-ymin)*0.05, ['$m$=$' int2str(l*2+1) '$'], 'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
        end
    end

    
    % �[�W (A)
    text(2.57, data(3, 1), '(A)', 'FontSize', 8, 'Color', 'r', 'VerticalAlignment', 'bottom', 'FontName', 'Times New Roman');
end

%{

clear all;

SCORE_TYPE = {'NED', 'match', 'group', 'type', 'token', 'boundary', 'coverage'};
SCORE_NAME = {'NED', 'matching', 'grouping', 'type', 'token', 'boundary', 'coverage'};
SPEAKER_TYPE = {'total', 'within'};
PRF = {'precision', 'recall', 'fscore'};

% Ū xit scores
lan = 'xit';
load([lan '/mfc.mat']);
mfc = stat;
load([lan '/merge.mat']);
merge = stat;
load([lan '/mrg2.mat']);
mrg2 = stat;
load([lan '/mbf.mat']);
mbf = stat;
clear stat;

load([lan '/baseline.mat']);

% �e�� (xit)
for i=1:6
    % ��ݭn�����ƨӬ� (total speaker, F-score)
    score_type = SCORE_TYPE{i};
    speaker_type = SPEAKER_TYPE{1};
    prf = PRF{3};

    tmp = [mfc.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = reshape(tmp, [], 4);

    tmp = [merge.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, [], 4)];

    tmp = [mrg2.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, [], 4)];

    tmp = [mbf.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, [], 4)];

    bsln = baseline.(score_type).(prf);
    
    xmin = 0.4;
    xmax = 20.6;
    
    % �l�ϼ��D
    subplot('position', [0.03 + floor((i-1)/3)*0.49, (0.25 + mod(6-i, 3)*0.3)*0.5, 0.45, 0.05*0.5]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmin], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmax, xmax], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [0, 0], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [1, 1], 'Color', 'black', 'LineWidth', 1);
    text(6.5, 0.5, SCORE_NAME{i}, 'FontSize', 15, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    text(0.5, 0.5, ['(JHU: ' num2str(bsln) ')'], 'FontSize', 13, 'FontName', 'Times New Roman');
    
    
    % �l�ϤU��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, (0.01 + mod(6-i, 3)*0.3)*0.5, 0.45, 0.04*0.5]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmin], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmax, xmax], [0, 1], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [0, 0], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [1, 1], 'Color', 'black', 'LineWidth', 1);
    for k=1:3
        line([3*k+0.5, 3*k+0.5], [0 1], 'Color', 'black', 'LineWidth', 3);
    end
    labels = {'(4)TOK-1st, MR-0', '(5)TOK-1st, MR-1', '(6)TOK-1st, MR-2', '(8)TOK-2nd, MR-1'};
    for k=1:4
        text(3*k-1, 0.5, labels{k}, 'FontSize', 12, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    end
    
    
    % �l��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, (0.05 + mod(6-i, 3)*0.3)*0.5, 0.45, 0.2*0.5]);
    
    % ��e�@��������
    b = bar(1:20, data);
    if i < 4
        set(b, 'FaceColor', 'white');
    else
        set(b, 'FaceColor', 'c');
    end
    
    

    
    % �]�w x, y �b�e�Ͻd��
    m = min(data(:));
    M = max(data(:));
    d = (M-m)/10;
    ymin = max(0, m-d);
    ymax = min(1, M+d);
    ymax = ymax + (ymax-ymin)*0.35;
    axis([xmin xmax ymin ymax]);
    
    % �M�� x �b����
    set(gca, 'XTick', []);
    
    % �C�ժ��϶������j�u
    for k=1:19
        line([k+0.5, k+0.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 2);
    end

    line([6.5 6.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 3);
    line([12.5 12.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 3);  
    line([16.5 16.5], [ymin, ymax], 'Color', 'black', 'LineWidth', 3);
    
    % �l�ϤW�U�[�u, �M���D�B�U�аϹj�}��
    line([xmin, xmax], [ymax, ymax], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [ymin, ymin], 'Color', 'black', 'LineWidth', 1);
    
    % �[�W�C�ժ��Ϫ��W�� (m=3,5,7, ...)
    for k=1:2
        for l=1:5
            text((k-1)*6 + l + 1, ymax - (ymax-ymin)*0.05, ['$' int2str(l*2+3) '$'], 'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
        end
        for l=1:4
            text(k*4 + l + 8, ymax - (ymax-ymin)*0.05, ['$' int2str(l*2+1) '$'], 'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
        end
    end
    text(7, ymax - (ymax-ymin)*0.05, '$3$', 'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
    text(0.8, ymax - (ymax-ymin)*0.05, '$3$', 'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
    
    % �[�W (B)
    text(19.57, data(20, 1), '(B)', 'FontSize', 8, 'Color', 'r', 'VerticalAlignment', 'bottom', 'FontName', 'Times New Roman');
    
    % �[�W (C)
    text(12.1, data(12, 3), '(C)', 'FontSize', 8, 'Color', 'r', 'VerticalAlignment', 'bottom', 'FontName', 'Times New Roman');
end

%}
