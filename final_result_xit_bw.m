clear all;

figure;
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
    data = reshape(tmp, 4, [])';

    tmp = [merge.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, 4, [])'];

    tmp = [mrg2.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, 4, [])'];

    tmp = [mbf.(score_type)];
    tmp = [tmp.(speaker_type)];
    tmp = [tmp.(prf)];
    data = [data; reshape(tmp, 4, [])'];

    if i==4
        bsln = baseline.('token').(prf);
    elseif i==5
        bsln = baseline.('type').(prf);
    else
        bsln = baseline.(score_type).(prf);
    end
    
    xmin = 0.2;
    xmax = 20.6;
    
    % �l�ϼ��D
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.25 + mod(6-i, 3)*0.3, 0.45, 0.05]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmax, xmin, xmin; xmin, xmax, xmax, xmax], [0, 0, 0, 1; 1, 1, 0, 1], 'Color', 'black', 'LineWidth', 1);
    text(10.5, 0.5, SCORE_NAME{i}, 'FontSize', 15, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    text(0.4, 0.5, ['(JHU: ' sprintf('%.3f', bsln) ')'], 'FontSize', 13, 'FontName', 'Times New Roman');
    
    % �[�W���W�� (b)
    if i==1
        text (xmin-1.2, 1, '(b)', 'FontSize', 16, 'FontName', 'Times New Roman')
    end    
    
    % �l�ϤU��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.01 + mod(6-i, 3)*0.3, 0.45, 0.04]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    axis([xmin xmax 0 1]);
    line([xmin, xmax, xmin, xmin; xmin, xmax, xmax, xmax], [0, 0, 0, 1; 1, 1, 0, 1], 'Color', 'black', 'LineWidth', 1);
    line([1; 1]*[6.5 12.5 16.5], [0; 1]*[1, 1, 1], 'Color', 'black', 'LineWidth', 3);
    labels = {'(4)TOK-1st, MR-0', '(5)TOK-1st, MR-1', '(6)TOK-1st, MR-2', '(8)TOK-2nd, MR-1'};
    pos = [3.5 9.5 14.5 18.5];
    text(pos, 0.5*ones(1,4), labels, 'FontSize', 10, 'HorizontalAlignment', 'center', 'FontName', 'Times New Roman');
    
    
    % �l��
    subplot('position', [0.03 + floor((i-1)/3)*0.49, 0.05 + mod(6-i, 3)*0.3, 0.45, 0.2]);
    
    
    
    % case by case �e���� (���ϤW��ܳ·�...)
    if i==2
        for j=[4:6 10:12 16 19 20]
            b = bar([1 2 j], data([1 2 j], :));
            for k=1:4
                if data(j, k) > bsln
                    set(b(k), 'FaceColor', 'k');
                elseif data(j, k) == bsln
                    set(b(k), 'FaceColor', [0.5,0.5,0.5]);
                else
                    set(b(k), 'FaceColor', 'w');
                end
            end
            if j==12
                set(b(3), 'EdgeColor', 'r');
            elseif j==20
                set(b(1), 'EdgeColor', 'r');
            end            
            hold on;
        end
        
        b = bar([1:3 7:9 13:15 17 18], data([1:3 7:9 13:15 17 18], :));
        set(b, 'FaceColor', 'white');  
    elseif i==4
        for j=[4:6 10:12 15 16 19 20]
            b = bar([1 2 j], data([1 2 j], :));
            for k=1:4
                if data(j, k) > bsln
                    set(b(k), 'FaceColor', 'k');
                elseif data(j, k) == bsln
                    set(b(k), 'FaceColor', [0.5,0.5,0.5]);
                else
                    set(b(k), 'FaceColor', 'w');
                end
            end
            if j==12
                set(b(3), 'EdgeColor', 'r');
            elseif j==20
                set(b(1), 'EdgeColor', 'r');
            end
            hold on;
        end
        
        b = bar([1:3 7:9 13 14 17 18], data([1:3 7:9 13 14 17 18], :));
        set(b, 'FaceColor', 'white');
    elseif i==5
        for j=[1 7 12 13 20]
            b = bar([18 19 j], data([18 19 j], :));
            for k=1:4
                if data(j, k) > bsln
                    set(b(k), 'FaceColor', 'k');
                elseif data(j, k) == bsln
                    set(b(k), 'FaceColor', [0.5,0.5,0.5]);
                else
                    set(b(k), 'FaceColor', 'w');
                end
            end
            if j==12
                set(b(3), 'EdgeColor', 'r');
            elseif j==20
                set(b(1), 'EdgeColor', 'r');
            end
            hold on;
        end
        
        b = bar([2:6, 8:11, 14:19], data([2:6, 8:11, 14:19], :));
        set(b, 'FaceColor', 'k');
    else
        b = bar([1 2 12], data([1 2 12], :));
        set(b(3), 'EdgeColor', 'r');
        if i==1 || i==3
            set(b, 'FaceColor', 'w');
        else
            set(b, 'FaceColor', 'k');
        end
        hold on;
        
        b = bar([1 2 20], data([1 2 20], :));
        set(b(1), 'EdgeColor', 'r');
        if i==1 || i==3
            set(b, 'FaceColor', 'w');
        else
            set(b, 'FaceColor', 'k');
        end
        
        b = bar([1:11 13:19], data([1:11 13:19], :));
        if i==1 || i==3
            set(b, 'FaceColor', 'w');
        else
            set(b, 'FaceColor', 'k');
        end
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
    line(ones(2,1)*(1.5:1:19.5), [ymin; ymax]*ones(1,19), 'Color', 'black', 'LineWidth', 2);
    line([1; 1]*[6.5 12.5 16.5], [0; 1]*[1, 1, 1], 'Color', 'black', 'LineWidth', 3);
    
    % �l�ϤW�U�[�u, �M���D�B�U�аϹj�}��
    line([xmin, xmax], [ymax, ymax], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [ymin, ymin], 'Color', 'black', 'LineWidth', 1);
    line([xmin, xmax], [1 1]*(ymax - (ymax-ymin)*0.17), 'Color', 'black', 'LineWidth', 1);
    
    % �[�W�C�ժ��Ϫ��W�� (m=3,5,7, ...)
    text([0.9, 2:20], (ymax - (ymax-ymin)*0.05)*ones(1,20), {'$m$=$3$', '$5$', '$7$', '$9$', '$11$', '$13$', '$3$', '$5$', '$7$', '$9$', '$11$', '$13$', '$3$', '$5$', '$7$', '$9$', '$3$', '$5$', '$7$', '$9$'}, ...
        'FontSize', 11, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'interpreter', 'latex');
    
    % �[�W (B)
    text(19.54, data(20, 1), '(B)', 'FontSize', 8, 'Color', 'r', 'VerticalAlignment', 'bottom', 'FontName', 'Times New Roman');
    
    % �[�W (C)
    text(11.85, data(12, 3), '(C)', 'FontSize', 8, 'Color', 'r', 'VerticalAlignment', 'bottom', 'FontName', 'Times New Roman');

end
