close all;
clc;


figure;

rotateRectangle(2)

function rotateRectangle(rounds)

    h = rectangle('Position',[5 5 5 5]);
    h.EdgeColor = 'b';
    axis([0 50 0 50]);
    pause(2);
    drawnow;

    for i=1:rounds
        % Moves Up
        for y=5:3:35
            h.Position = [5 y 5 5];
            pause(0.01);
            drawnow;
        end

        
        % Moves Right
        for x=5:3:35
            h.Position = [x 35 5 5]; 
            pause(0.01);
            drawnow;
        end
        
        % Moves Down
        for y=35:-3:5
            h.Position = [35 y 5 5];
            pause(0.01);
            drawnow;
        end
        
        % Moves Left
        for x=35:-3:5
            h.Position = [x 5 5 5];
            pause(0.01);
            drawnow;
        end
    end
end




